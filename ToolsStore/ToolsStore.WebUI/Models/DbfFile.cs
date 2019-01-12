using System;
using System.Data;

namespace ToolsStore.WebUI.Models
{
    public abstract class DbfFile
    {
        public static void DataTableToDbf(System.Data.DataTable DT, String str_file)
        {
            System.IO.FileStream FS = new System.IO.FileStream(str_file, System.IO.FileMode.Create);
            DataTableToDbf(DT, FS);
            FS.Close();
        }

        public static void DataTableToDbf(System.Data.DataTable DT, System.IO.Stream FS)
        {
            // Создаю таблицу
            // Формат dBASE III 2.0
            //Заголовок---------------------------------------------------------------------------------------------

            byte[] buffer = new byte[] { 0x03, 0x63, 0x04, 0x04 };
            FS.Write(buffer, 0, buffer.Length);
            buffer = new byte[] {
					(byte)(((DT.Rows.Count % 0x1000000) % 0x10000) % 0x100),
						(byte)(((DT.Rows.Count % 0x1000000) % 0x10000) / 0x100),
						(byte)(( DT.Rows.Count % 0x1000000) / 0x10000),
						(byte)( DT.Rows.Count / 0x1000000)
				}; // Word32 . кол-во строк 5-8 байты
            FS.Write(buffer, 0, buffer.Length);
            int i = (DT.Columns.Count + 1) * 32 + 1; // Изврат 8,9 Размер заголовка в байтах 
            buffer = new byte[] {
					(byte)( i % 0x100),
						(byte)( i / 0x100)
				}; // Word16 . кол-во колонок с извратом 10,11 байты
            FS.Write(buffer, 0, buffer.Length);

            string[] FieldName = new string[DT.Columns.Count]; // Массив названий полей
            string[] FieldType = new string[DT.Columns.Count]; // Массив типов полей
            byte[] FieldSize = new byte[DT.Columns.Count]; // Массив размеров полей
            byte[] FieldDigs = new byte[DT.Columns.Count]; // Массив размеров дробной части
            int s = 1; // Считаю длину заголовка
            foreach (DataColumn C in DT.Columns)
            {
                String l = C.ColumnName.ToUpper(); // Имя колонки
                while (l.Length < 10) { l = l + "\0"; } // Подгоняю по размеру (10 байт)
                FieldName[C.Ordinal] = l.Substring(0, 10) + "\0"; // Результат
                FieldType[C.Ordinal] = "C";
                FieldSize[C.Ordinal] = 50;
                FieldDigs[C.Ordinal] = 0;
                if (C.DataType == typeof(string)) { FieldType[C.Ordinal] = "C"; FieldSize[C.Ordinal] = (byte)C.MaxLength >= 255 ? (byte)255 : (byte)C.MaxLength; }
                if (C.DataType == typeof(Boolean)) { FieldType[C.Ordinal] = "L"; FieldSize[C.Ordinal] = 1; }
                if (C.DataType == typeof(Byte)) { FieldType[C.Ordinal] = "N"; FieldSize[C.Ordinal] = 1; }
                if (C.DataType == typeof(DateTime)) { FieldType[C.Ordinal] = "D"; FieldSize[C.Ordinal] = 8; }
                if (C.DataType == typeof(Decimal)) { FieldType[C.Ordinal] = "F"; FieldSize[C.Ordinal] = 38; FieldDigs[C.Ordinal] = 5; }
                if (C.DataType == typeof(Double)) { FieldType[C.Ordinal] = "F"; FieldSize[C.Ordinal] = 38; FieldDigs[C.Ordinal] = 5; }
                if (C.DataType == typeof(Int16)) { FieldType[C.Ordinal] = "N"; FieldSize[C.Ordinal] = 6; }
                if (C.DataType == typeof(Int32)) { FieldType[C.Ordinal] = "N"; FieldSize[C.Ordinal] = 11; }
                if (C.DataType == typeof(Int64)) { FieldType[C.Ordinal] = "N"; FieldSize[C.Ordinal] = 21; }
                if (C.DataType == typeof(SByte)) { FieldType[C.Ordinal] = "N"; FieldSize[C.Ordinal] = 6; }
                if (C.DataType == typeof(Single)) { FieldType[C.Ordinal] = "F"; FieldSize[C.Ordinal] = 38; FieldDigs[C.Ordinal] = 5; }
                if (C.DataType == typeof(UInt16)) { FieldType[C.Ordinal] = "N"; FieldSize[C.Ordinal] = 6; }
                if (C.DataType == typeof(UInt32)) { FieldType[C.Ordinal] = "N"; FieldSize[C.Ordinal] = 11; }
                if (C.DataType == typeof(UInt64)) { FieldType[C.Ordinal] = "N"; FieldSize[C.Ordinal] = 21; }
                // If column caption ends with [x] or [x.x] make column size/presision the same
                System.Text.RegularExpressions.Match m = System.Text.RegularExpressions.Regex.Match(C.Caption, "(\\[([A-Za-z])\\])?\\[([0-9]+)(\\.([0-9]+))?\\]$");
                if (m.Success)
                {
                    if (!System.String.IsNullOrEmpty(m.Groups[2].Value))
                    {
                        System.String typ = m.Groups[2].Value.ToUpper();
                        FieldType[C.Ordinal] = typ;
                        if (typ == "N")
                            FieldDigs[C.Ordinal] = 0;
                    }
                    if (!System.String.IsNullOrEmpty(m.Groups[5].Value))
                    {
                        byte ord = Convert.ToByte(m.Groups[3].Value);
                        byte prs = Convert.ToByte(m.Groups[5].Value);
                        FieldSize[C.Ordinal] = (byte)(ord + ((prs == 0) ? 0 : (prs + 1)));
                        FieldDigs[C.Ordinal] = prs;
                    }
                    else
                    {
                        byte siz = Convert.ToByte(m.Groups[3].Value);
                        FieldSize[C.Ordinal] = siz;
                    }
                }
                s = s + FieldSize[C.Ordinal];
            }
            buffer = new byte[] {
					(byte)(s % 0x100), 
						(byte)(s / 0x100)
				}; // Пишу длину заголовка 12-13 байты
            FS.Write(buffer, 0, buffer.Length);
            for (int j = 0; j < 17; j++) { FS.WriteByte(0x00); } // Пишу всякий хлам - 17 байт,
            FS.WriteByte(0x65); // CP866
            FS.WriteByte(0x00); // 0
            FS.WriteByte(0x00); // 0
            // итого: 32 байта - базовый заголовок DBF
            // Заполняю заголовок
            foreach (DataColumn C in DT.Columns)
            {
                buffer = System.Text.Encoding.Default.GetBytes(FieldName[C.Ordinal]); // Название поля
                FS.Write(buffer, 0, buffer.Length);
                buffer = new byte[] {
						System.Text.Encoding.ASCII.GetBytes(FieldType[C.Ordinal])[0],
							0x00, 
							0x00,
							0x00, 
							0x00
					}; // Размер
                FS.Write(buffer, 0, buffer.Length);
                buffer = new byte[] {
						FieldSize[C.Ordinal],
							FieldDigs[C.Ordinal]
					}; // Размерность
                FS.Write(buffer, 0, buffer.Length);
                buffer = new byte[] {0x00, 0x00, 0x00, 0x00, 0x00,
						0x00, 0x00, 0x00, 0x00, 0x00,
						0x00, 0x00, 0x00, 0x00}; // 14 нулей
                FS.Write(buffer, 0, buffer.Length);
            }
            FS.WriteByte(0x0D); // Конец описания таблицы
            //------------------------------------------------------------------------------------------------
            System.Globalization.CultureInfo ci = new System.Globalization.CultureInfo("en-US", false);
            System.Globalization.DateTimeFormatInfo dfi = ci.DateTimeFormat;
            System.Globalization.NumberFormatInfo nfi = ci.NumberFormat;
            String Spaces = "";
            while (Spaces.Length < 255) Spaces = Spaces + " ";
            foreach (DataRow R in DT.Rows)
            {
                FS.WriteByte(0x20); // Пишу данные
                foreach (DataColumn C in DT.Columns)
                {
                    nfi.NumberDecimalDigits = FieldDigs[C.Ordinal];
                    String l = R[C].ToString();
                    if (l != "") // Проверка на NULL
                    {
                        if (FieldType[C.Ordinal] == "")
                        {
                            l = bool.Parse(l).ToString();
                        }
                        else
                        {
                            if (FieldType[C.Ordinal] == "N")
                            {
                                l = System.Decimal.Parse(l).ToString(nfi);
                            }
                            else
                            {
                                if (FieldType[C.Ordinal] == "F")
                                {
                                    l = Double.Parse(l).ToString("F", nfi);
                                }
                                else
                                {
                                    if (FieldType[C.Ordinal] == "D")
                                    {
                                        l = DateTime.Parse(l).ToString("yyyyMMdd", dfi);
                                    }
                                    else
                                    {
                                        l = l.Trim() + Spaces;
                                    }
                                }
                            }
                        }
                    }
                    else
                    {
                        if (FieldType[C.Ordinal] == "C"
                            || FieldType[C.Ordinal] == "D")
                            l = Spaces;
                    }
                    while (l.Length < FieldSize[C.Ordinal]) { l = l + "\0"; }
                    l = l.Substring(0, FieldSize[C.Ordinal]); // Корректирую размер
                    buffer = System.Text.Encoding.GetEncoding(866).GetBytes(l); // Записываю в кодировке (MS-DOS Russian)
                    FS.Write(buffer, 0, buffer.Length);
                    //Application.DoEvents();
                }
            }
            FS.WriteByte(0x1A); // Конец данных
        }
    };
}