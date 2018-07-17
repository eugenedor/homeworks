namespace ToolsStoreService
{
    partial class ProjectInstaller
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary> 
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Component Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.spiToolsStoreService = new System.ServiceProcess.ServiceProcessInstaller();
            this.siToolsStoreService = new System.ServiceProcess.ServiceInstaller();
            // 
            // spiToolsStoreService
            // 
            this.spiToolsStoreService.Account = System.ServiceProcess.ServiceAccount.LocalSystem;
            this.spiToolsStoreService.Password = null;
            this.spiToolsStoreService.Username = null;
            // 
            // siToolsStoreService
            // 
            this.siToolsStoreService.ServiceName = "ToolsStoreService";
            this.siToolsStoreService.StartType = System.ServiceProcess.ServiceStartMode.Automatic;
            // 
            // ProjectInstaller
            // 
            this.Installers.AddRange(new System.Configuration.Install.Installer[] {
            this.spiToolsStoreService,
            this.siToolsStoreService});

        }

        #endregion

        private System.ServiceProcess.ServiceProcessInstaller spiToolsStoreService;
        private System.ServiceProcess.ServiceInstaller siToolsStoreService;
    }
}