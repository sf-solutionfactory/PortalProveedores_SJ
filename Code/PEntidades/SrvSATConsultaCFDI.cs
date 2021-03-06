﻿////------------------------------------------------------------------------------
//// <auto-generated>
////     Este código fue generado por una herramienta.
////     Versión de runtime:4.0.30319.17929
////
////     Los cambios en este archivo podrían causar un comportamiento incorrecto y se perderán si
////     se vuelve a generar el código.
//// </auto-generated>
////------------------------------------------------------------------------------

namespace PEntidades.SrvSATConsultaCFDI
{
    using System.Net;//ADD SF RSG 11.02.2021
    using System.Runtime.Serialization;

    //    [System.Diagnostics.DebuggerStepThroughAttribute()]
    //    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    //    [System.Runtime.Serialization.DataContractAttribute(Name="Acuse", Namespace="http://schemas.datacontract.org/2004/07/Sat.Cfdi.Negocio.ConsultaCfdi.Servicio")]
    //    public partial class Acuse : object, System.Runtime.Serialization.IExtensibleDataObject
    //    {

    //        private System.Runtime.Serialization.ExtensionDataObject extensionDataField;

    //        private string CodigoEstatusField;

    //        private string EstadoField;

    //        public System.Runtime.Serialization.ExtensionDataObject ExtensionData
    //        {
    //            get
    //            {
    //                return this.extensionDataField;
    //            }
    //            set
    //            {
    //                this.extensionDataField = value;
    //            }
    //        }

    //        [System.Runtime.Serialization.DataMemberAttribute()]
    //        public string CodigoEstatus
    //        {
    //            get
    //            {
    //                return this.CodigoEstatusField;
    //            }
    //            set
    //            {
    //                this.CodigoEstatusField = value;
    //            }
    //        }

    //        [System.Runtime.Serialization.DataMemberAttribute()]
    //        public string Estado
    //        {
    //            get
    //            {
    //                return this.EstadoField;
    //            }
    //            set
    //            {
    //                this.EstadoField = value;
    //            }
    //        }
    //    }



    //    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    //    [System.ServiceModel.ServiceContractAttribute(ConfigurationName="IConsultaCFDIService")]
    //    public interface IConsultaCFDIService
    //    {

    //        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IConsultaCFDIService/Consulta", ReplyAction="http://tempuri.org/IConsultaCFDIService/ConsultaResponse")]
    //        PEntidades.SrvSATConsultaCFDI.Acuse Consulta(string expresionImpresa);

    //        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IConsultaCFDIService/Consulta", ReplyAction="http://tempuri.org/IConsultaCFDIService/ConsultaResponse")]
    //        System.Threading.Tasks.Task<PEntidades.SrvSATConsultaCFDI.Acuse> ConsultaAsync(string expresionImpresa);
    //    }

    //    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    //    public interface IConsultaCFDIServiceChannel : IConsultaCFDIService, System.ServiceModel.IClientChannel
    //    {
    //    }

    //    [System.Diagnostics.DebuggerStepThroughAttribute()]
    //    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]

    //    public partial class ConsultaCFDIServiceClient : System.ServiceModel.ClientBase<IConsultaCFDIService>, IConsultaCFDIService
    //    {

    //        public ConsultaCFDIServiceClient()
    //        {
    //        }

    //        public ConsultaCFDIServiceClient(string endpointConfigurationName) : 
    //                base(endpointConfigurationName)
    //        {
    //        }

    //        public ConsultaCFDIServiceClient(string endpointConfigurationName, string remoteAddress) : 
    //                base(endpointConfigurationName, remoteAddress)
    //        {
    //        }

    //        public ConsultaCFDIServiceClient(string endpointConfigurationName, System.ServiceModel.EndpointAddress remoteAddress) : 
    //                base(endpointConfigurationName, remoteAddress)
    //        {
    //        }

    //        public ConsultaCFDIServiceClient(System.ServiceModel.Channels.Binding binding, System.ServiceModel.EndpointAddress remoteAddress) : 
    //                base(binding, remoteAddress)
    //        {
    //        }

    //        public PEntidades.SrvSATConsultaCFDI.Acuse Consulta(string expresionImpresa)
    //        {
    //            return base.Channel.Consulta(expresionImpresa);
    //        }

    //        public System.Threading.Tasks.Task<PEntidades.SrvSATConsultaCFDI.Acuse> ConsultaAsync(string expresionImpresa)
    //        {
    //            return base.Channel.ConsultaAsync(expresionImpresa);
    //        }
    //    }

    public class ValidarCFDI
    {
        /**
         * Autor : Luis Jesús Castro Guerrero, @ljesuscastrog
         * Fecha : miercoles 12 de febrero 2014, 09:52 a.m.
         * Nota  : Clase que sirve como clase proxy, de la clase proxy del webservise, (que loco).
         */
        public ValidarCFDI()
        {

        }

        public PEntidades.SrvSATConsultaCFDI.MiAcuse esValidoCFDI(string expresionImpresa)
        {
            //if (System.Net.ServicePointManager.SecurityProtocol == (SecurityProtocolType.Ssl3 | SecurityProtocolType.Tls))      //ADD SF RSG 11.02.2021      //DELETE SF RSG 12.04.2021
            //{
            System.Net.ServicePointManager.SecurityProtocol = (SecurityProtocolType)(0xc0 | 0x300 | 0xc00);
            System.Net.ServicePointManager.SecurityProtocol &= ~SecurityProtocolType.Ssl3;                                          //ADD SF RSG 12.04.2021
            //}
            PEntidades.SrvSATConsultaCFDI.ConsultaCFDIServiceClient cli = new SrvSATConsultaCFDI.ConsultaCFDIServiceClient(
                new System.ServiceModel.BasicHttpBinding("BasicHttpBinding_IConsultaCFDIService"),
                new System.ServiceModel.EndpointAddress("https://consultaqr.facturaelectronica.sat.gob.mx/ConsultaCFDIService.svc"));
            // new System.ServiceModel.EndpointAddress("https://consultaqr.facturaelectronica.sat.gob.mx/ConsultaCFDIService.svc"));
            cli.Open();
            PEntidades.SrvSATConsultaCFDI.Acuse resul = cli.Consulta(expresionImpresa);
            MiAcuse retorno = new MiAcuse();
            retorno.Estado = resul.Estado;
            retorno.CodigoEstatus = resul.CodigoEstatus;
            cli.Close();
            return retorno;
        }
    }
    public class MiAcuse
    {
        private string codigoEstatus;
        private string estado;

        public MiAcuse()
        {
        }

        public string CodigoEstatus
        {
            get { return codigoEstatus; }
            set { codigoEstatus = value; }
        }

        public string Estado
        {
            get { return estado; }
            set { estado = value; }
        }

    }
}