using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PNegocio
{
    public class PartidasAbiertas
    {
        public PartidasAbiertas()
        {
        }

        public string[] status = new string[0];
        public List<PEntidades.PAbiertasYPago> getfacturasAbiertas(string fecha1, string fecha2, List<string[]> listaDiferentesInstancias)
        {

            List<PEntidades.PAbiertasYPago> list = new List<PEntidades.PAbiertasYPago>();
            PEntidades.SrvSAPUProv.Z_UPARTIDAS_ABIERTAS abiertas = new PEntidades.SrvSAPUProv.Z_UPARTIDAS_ABIERTAS();
            PEntidades.SrvSAPUProv.ZWS_UPROVEEDORESClient srv;
            status = new string[listaDiferentesInstancias.Count];
            for (int j = 0; j < listaDiferentesInstancias.Count; j++) // listaDiferentesInstancias contiene idInstacia, endpoint, y las sociedades separadas por "," ;  
            {
                try
                {
                    srv = new PPersistencia.WebServices().getZWS_UPROVEEDORESInstanceNew(
                    listaDiferentesInstancias[j][1].ToString().Trim(), 
                    listaDiferentesInstancias[j][4].Split(new Char[] { ',' })
                    );
                    
                    srv.Open();
                    srv.InnerChannel.OperationTimeout = new TimeSpan(0, 10, 0);
                    PEntidades.SrvSAPUProv.ZEPLANT_PROV[] objetoSoc;
                    PEntidades.SrvSAPUProv.ZELIFNR_PROV[] objLifnr;

                    string[] splitSoc = listaDiferentesInstancias[j][2].Split(new Char[] { ',' });
                    string[] splitLifnr = listaDiferentesInstancias[j][3].Split(new Char[] { ',' });

                    //objetoSoc = PEntidades.Utiles.objetoSociedad(splitSoc);
                    //objLifnr = PEntidades.Utiles.objetoLifnr(splitLifnr);
                    
                    abiertas.DATE1 = Gen.Util.CS.Gen.convertirFecha_SAP(fecha1);
                    abiertas.DATE2 = Gen.Util.CS.Gen.convertirFecha_SAP(fecha2);
                    abiertas.PROVEEDOR = PEntidades.Utiles.objetoLifnr(splitLifnr);
                    abiertas.SOCIEDAD = PEntidades.Utiles.objetoSociedad(splitSoc);
                    var resultado = srv.Z_UPARTIDAS_ABIERTAS(abiertas);
                    int cantidad = resultado.PARTIDAS_ABIERTAS.Length;

                    PEntidades.PAbiertasYPago objPabYPag;
                    for (int i = 0; i < cantidad; i++)
                    {
                        objPabYPag = new PEntidades.PAbiertasYPago();

                        //string ZUONR = resultado.ElementAt(i).ZUONR.ToString();
                        //string BELNR = resultado.ElementAt(i).BELNR.ToString();
                        //string BLART = resultado.ElementAt(i).BLART.ToString();
                        //string BLDAT = resultado.ElementAt(i).BLDAT.ToString();
                        //float DMSHB = float.Parse(resultado.ElementAt(i).DMSHB.ToString());
                        //string HWAER = resultado.ElementAt(i).HWAER.ToString();

                        //string XBLNR = resultado.ElementAt(i).XBLNR.ToString();
                        //string NAME1 = resultado.ElementAt(i).NAME1.ToString();
                        //string EBELN = resultado.ElementAt(i).EBELN.ToString();

                        //string F_BASE = resultado.ElementAt(i).F_BASE.ToString();
                        //string F_VENCIM = resultado.ElementAt(i).F_VENCIM.ToString();

                        string ZUONR = resultado.PARTIDAS_ABIERTAS[i].ZUONR.ToString();
                        string BELNR = resultado.PARTIDAS_ABIERTAS[i].BELNR.ToString();
                        string BLART = resultado.PARTIDAS_ABIERTAS[i].BLART.ToString();
                        string BLDAT = resultado.PARTIDAS_ABIERTAS[i].BLDAT.ToString();
                        float DMSHB = float.Parse(resultado.PARTIDAS_ABIERTAS[i].DMSHB.ToString());
                        string HWAER = resultado.PARTIDAS_ABIERTAS[i].HWAER.ToString();

                        string XBLNR = resultado.PARTIDAS_ABIERTAS[i].XBLNR.ToString();
                        string NAME1 = resultado.PARTIDAS_ABIERTAS[i].NAME1.ToString();
                        string EBELN = resultado.PARTIDAS_ABIERTAS[i].EBELN.ToString();

                        string F_BASE = resultado.PARTIDAS_ABIERTAS[i].F_BASE.ToString();
                        string F_VENCIM = resultado.PARTIDAS_ABIERTAS[i].F_VENCIM.ToString();

                        objPabYPag.IDINSTANCIA = int.Parse(listaDiferentesInstancias[j][0]);

                        objPabYPag.ZUONR1 = ZUONR;
                        objPabYPag.BELNR1 = BELNR;
                        objPabYPag.BLART1 = BLART;
                        objPabYPag.BLDAT1 = BLDAT;
                        objPabYPag.DMSHB1 = DMSHB;
                        objPabYPag.HWAER1 = HWAER;

                        objPabYPag.XBLNR = XBLNR;
                        objPabYPag.NAME1 = NAME1;
                        objPabYPag.EBELN = EBELN;

                        objPabYPag.F_BASE = F_BASE;
                        objPabYPag.F_VENCIM = F_VENCIM;

                        list.Add(objPabYPag);
                    }

                    srv.Close();

                }
                catch (Exception e)
                {
                    status[j] = "Error al cargar datos, reintente o vuelva a intentarlo más tarde.";
                    //status[j] = "Error al cargar en la instancia: " + listaDiferentesInstancias[j][6];
                    //status[j] += "" + e;
                }
            }
            return list;
        }

        private PEntidades.SrvSAPUProv.ZELIFNR_PROV[] objetoLifnr(string[] lifnrs)
        {

            PEntidades.SrvSAPUProv.ZELIFNR_PROV[] Objlifnrs = new PEntidades.SrvSAPUProv.ZELIFNR_PROV[lifnrs.Length];// hace un objeto del tipo ZEPLANT_PROV 
            int cont = 0;
            foreach (string lifnr in lifnrs)
            {
                Objlifnrs[cont] = new PEntidades.SrvSAPUProv.ZELIFNR_PROV();
                Objlifnrs[cont].LIFNR = lifnr;
                cont++;
            }
            return Objlifnrs;
        }
    }
}
