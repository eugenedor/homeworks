using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Algorithms
{
    public static class CaesarCipher
    {
        private static char cipher(char ch, int key)
        {
            if (!char.IsLetter(ch))
                return ch;

            var offset = char.IsUpper(ch) ? 'A' : 'a';

            return (char)((ch - offset + key) % 26 + offset);
        }
        public static string Encipher(string input, int key)
        {
            var output = string.Empty;

            foreach (var ch in input)
            {
                output += cipher(ch, key);
            }

            return output;
        }

        public static string Decipher(string input, int key)
        {
            return Encipher(input, 26 - key);
        }
    }
}
