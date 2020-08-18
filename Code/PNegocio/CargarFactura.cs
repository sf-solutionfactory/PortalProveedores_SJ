using PPersistencia;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PNegocio
{
    public class CargarFactura
    {

        public int setFacturascargadasNew(string bukrs, string correo, string ebeln, string lifnr, string msjsap, string msgsat, string estatus, string tipo,
            string werks, string xblnr, string fecha_xml, string xmlfile, string endpoint, string[] userPass, byte[] raw, string uuid, decimal total,
            string numeroItem, string BELNR, string BWTAR, string KSCHL, string tipoarchivo, byte[] rawpdf, string pdffile, decimal retencion)
        {

            PEntidades.SrvSAPUProv.Z_UFAC_CARGADASResponse result;
            PEntidades.SrvSAPUProv.Z_UFAC_CARGADAS cargadas = new PEntidades.SrvSAPUProv.Z_UFAC_CARGADAS();
            int res = 0;
            PEntidades.SrvSAPUProv.ZWS_UPROVEEDORESClient srv = new PPersistencia.WebServices().getZWS_UPROVEEDORESInstanceNew(endpoint, userPass);
            cargadas.BELNR = BELNR;
            cargadas.BUKRS = bukrs;
            cargadas.BWTAR = BWTAR;
            cargadas.CORREO = correo;
            cargadas.DESADJUNTAR = "";
            cargadas.EBELN = ebeln;
            cargadas.EBELP = numeroItem;
            cargadas.FECHA_XML = fecha_xml;
            cargadas.IMP_RETEN = retencion;
            cargadas.KSCHL = KSCHL;
            cargadas.LIFNR = lifnr;
            cargadas.MSJ_SAP = msjsap;
            cargadas.MSJ_SAT = msgsat;
            cargadas.PDFFILE = pdffile;
            cargadas.RAW = raw;
            cargadas.RAWPDF = rawpdf;
            cargadas.STATUS = estatus;
            cargadas.TIPO = tipo;
            cargadas.TIPOARCHIVO = tipoarchivo;
            cargadas.UUID_XML = null;
            cargadas.WERKS = werks;
            cargadas.XBLNR = xblnr;
            cargadas.XMLFILE = xmlfile;
            cargadas.ZCFDI_UUID = uuid;
            srv.Open();
            srv.InnerChannel.OperationTimeout = new TimeSpan(0, 10, 0);
            result = srv.Z_UFAC_CARGADAS(cargadas);
            srv.Close();
            if (result.RESULT != "" && result != null)
            {
                try
                {
                    res = int.Parse(result.RESULT.Trim());
                }
                catch (Exception)
                {
                    res = 1;
                }

            }
            return res;
        }

        public int desvincular(List<string[]> listaDiferentesInstancias, string[] uuid)
        {
            PEntidades.SrvSAPUProv.ZEDATA_UUID[] objetoUui = PEntidades.Utiles.objetoUuid(uuid);
            PEntidades.SrvSAPUProv.Z_UFAC_CARGADAS cargadas = new PEntidades.SrvSAPUProv.Z_UFAC_CARGADAS();
            PEntidades.SrvSAPUProv.Z_UFAC_CARGADASResponse result;
            int res = 0;
            PEntidades.SrvSAPUProv.ZWS_UPROVEEDORESClient srv = new PPersistencia.WebServices().getZWS_UPROVEEDORESInstanceNew(
                    listaDiferentesInstancias[0][1].ToString().Trim(),
                    listaDiferentesInstancias[0][4].Split(new Char[] { ',' })
                    );
            cargadas.BELNR = "";
            cargadas.BUKRS = "";
            cargadas.BWTAR = "";
            cargadas.CORREO = "";
            cargadas.DESADJUNTAR = "X";
            cargadas.EBELN = "";
            cargadas.EBELP = "";
            cargadas.FECHA_XML = "";
            cargadas.IMP_RETEN = 0;
            cargadas.KSCHL = "";
            cargadas.LIFNR = "";
            cargadas.MSJ_SAP = "";
            cargadas.MSJ_SAT = "";
            cargadas.PDFFILE = "";
            cargadas.RAW = null;
            cargadas.RAWPDF = null;
            cargadas.STATUS = "";
            cargadas.TIPO = "";
            cargadas.TIPOARCHIVO = "";
            cargadas.UUID_XML = objetoUui;
            cargadas.WERKS = "";
            cargadas.XBLNR = "";
            cargadas.XMLFILE = "";
            cargadas.ZCFDI_UUID = "";
            srv.Open();
            srv.InnerChannel.OperationTimeout = new TimeSpan(0, 10, 0);
            result = srv.Z_UFAC_CARGADAS(cargadas);
            srv.Close();
            if (result.RESULT != "" && result != null)
            {
                res = int.Parse(result.RESULT.Trim());
            }
            return res;
        }

        public string getMaxXML()
        {
            ejecutaProcedures ejecPd = new ejecutaProcedures();
            string[] res = ejecPd.ejcPsdMaxXML();
            return res[0];
        }

        public string otener_correo(string sqlstring)
        {
            ejecutaProcedures ejecPd = new ejecutaProcedures();
            string[] res = ejecPd.ejecCon(sqlstring);
            return res[0];
        }
    }
}
