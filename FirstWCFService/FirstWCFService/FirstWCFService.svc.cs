using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace FirstWCFService
{
    public class FirstWCFService : IFirstWCFService
    {
        public void DoWork()
        {
            throw new NotImplementedException();
        }

        public string First(string name)
        {
            return "Welcome to the first method WCF web service application" + name;
        }

        public string Second()
        {
            return "Welcome to the second method WCF web service application!";
        }

        public string Third(string name)
        {
            return "Welcome to the third method WCF web service application" + name;
        }
    }
}
