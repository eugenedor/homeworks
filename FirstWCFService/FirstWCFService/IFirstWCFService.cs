using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace FirstWCFService
{
    [ServiceContract]
    public interface IFirstWCFService
    {
        [OperationContract]
        void DoWork();

        [OperationContract]
        string First(string name);

        [OperationContract]
        string Second();

        [OperationContract]
        string Third(string name);
    }
}
