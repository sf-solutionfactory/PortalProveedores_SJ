﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
//using PEntidades.SrvSAPProveedores; /// no ZZZ

namespace PNegocio
{
    public class FacturasNE
    {
        public FacturasNE()
        {
        }

        public string[] status = new string[0];

        public List<PEntidades.FacturasXVerificar> getListFacturasNew( 
            List<string[]> listaDiferentesInstancias,
            string ordenarOrden,string ordenarRef,
            string fhigh, string flow,
            string facthig, string factlow,
            string monedahig, string monedalow,
            string refhig, string refLow, ref string mensaje
            //objetoSoc, "f hig", "f low", "fact hig", "fact low", "moneda hig", "moneda low", objLifnr, ordenarOrden, ordenarRef, "ref hig", "ref low"
            ) // informacion importante = u.sociedad_bukrs, u.RFC, u.lifnr, u.instancia, i.endpointAdd

        {
            //int contadorIntentos = 0;
            List<PEntidades.FacturasXVerificar> lstResul = new List<PEntidades.FacturasXVerificar>(); // objeto lista
            PEntidades.SrvSAPUProv.Z_UFAC_VERIFICAR verificar = new PEntidades.SrvSAPUProv.Z_UFAC_VERIFICAR();
            status = new string[listaDiferentesInstancias.Count];
            for (int j = 0; j < listaDiferentesInstancias.Count; j++) // listaDiferentesInstancias contiene idInstacia, endpoint, y las sociedades separadas por "," ;  
            {
                try
                {
                    PEntidades.SrvSAPUProv.ZWS_UPROVEEDORESClient srv = new PPersistencia.WebServices().getZWS_UPROVEEDORESInstanceNew(
                    listaDiferentesInstancias[j][1].ToString().Trim(),
                    listaDiferentesInstancias[j][4].Split(new Char[] { ',' })
                    );
                    
                    srv.Open();
                    srv.InnerChannel.OperationTimeout = new TimeSpan(0, 10, 0);
                    string[] splitSoc = listaDiferentesInstancias[j][2].Split(new Char[] { ',' });
                    string[] splitLifnr = listaDiferentesInstancias[j][3].Split(new Char[] { ',' });

                    //objetoSoc = PEntidades.Utiles.objetoSociedad(splitSoc);
                    //objLifnr = PEntidades.Utiles.objetoLifnr(splitLifnr);
                    
                    verificar.PROVEEDOR = PEntidades.Utiles.objetoLifnr(splitLifnr);
                    verificar.CENTRO = PEntidades.Utiles.objetoSociedad(splitSoc);
                    verificar.F_COMPRA_HIGH = fhigh;
                    verificar.F_COMPRA_LOW = flow;
                    verificar.F_FAC_HIGH = facthig;
                    verificar.F_FAC_LOW = factlow;
                    verificar.MONEDA_HIGH = monedahig;
                    verificar.MONEDA_LOW = monedalow;
                    verificar.P_BLOCK = "X";
                    verificar.P_ORDPED = ordenarOrden;
                    verificar.P_ORDREF = ordenarRef;
                    verificar.REFERENCIA_HIGH = refhig;
                    verificar.REFERENCIA_LOW = refLow;
                    PEntidades.SrvSAPUProv.Z_UFAC_VERIFICARResponse resul = srv.Z_UFAC_VERIFICAR(verificar);
                    mensaje = resul.MENSAJE;
                    //contadorIntentos = 0;
                    //var resul = srv.Z_UFAC_VERIFICAR(objetoSoc, "f hig", "f loq", "fact hig", "fact low", "moneda hig", "moneda low", objLifnr, ordenarOrden, ordenarRef, "ref hig", "ref low");
                    for (int i = 0; i < resul.IT_F_VERIFICAR.Length; i++)
                    {
                        PEntidades.FacturasXVerificar tmpFac = new PEntidades.FacturasXVerificar(); // objeto de la lista

                        tmpFac.IDINSTANCIA = int.Parse(listaDiferentesInstancias[j][0]);
                        tmpFac.TIPO = resul.IT_F_VERIFICAR[i].TIPO;
                        tmpFac.EBELN = resul.IT_F_VERIFICAR[i].EBELN;
                        //tmpFac.RFCCorrespon = listaDiferentesInstancias[j][5];
                        tmpFac.RFCCorrespon = resul.IT_F_VERIFICAR[i].RFC_PROVEEDOR;
                        tmpFac.RFCSociedad = resul.IT_F_VERIFICAR[i].RFC_SOC;
                        tmpFac.DescripcionErrorSAP = resul.IT_F_VERIFICAR[i].FACT_SAP;
                        tmpFac.DescripcionErrorSAT = resul.IT_F_VERIFICAR[i].FACT_SAT;
                        tmpFac.InsidenciaPersonal = resul.IT_F_VERIFICAR[i].INCIDENCIA;
                        tmpFac.XBLNR2 = resul.IT_F_VERIFICAR[i].XBLNR2;
                        tmpFac.LIFNR = resul.IT_F_VERIFICAR[i].LIFNR;
                        tmpFac.BUKRS = resul.IT_F_VERIFICAR[i].BUKRS;
                        tmpFac.WERKS = resul.IT_F_VERIFICAR[i].WERKS.ToString();
                        tmpFac.BUDAT = resul.IT_F_VERIFICAR[i].BUDAT;
                        tmpFac.BLDAT = resul.IT_F_VERIFICAR[i].BLDAT;
                        tmpFac.WRBTR = resul.IT_F_VERIFICAR[i].WRBTR.ToString();//Decimal
                         tmpFac.IVA = resul.IT_F_VERIFICAR[i].IVA.ToString();
                        tmpFac.MWSKZ = resul.IT_F_VERIFICAR[i].MWSKZ.ToString();//Decimal
                        tmpFac.IMP_TOTAL = resul.IT_F_VERIFICAR[i].IMP_TOTAL.ToString();//Decimal
                        tmpFac.RETENCION = resul.IT_F_VERIFICAR[i].RETENCION.ToString();//Decimal
                        tmpFac.WAERS = resul.IT_F_VERIFICAR[i].WAERS.ToString();//Decimal
                        tmpFac.SALDO = resul.IT_F_VERIFICAR[i].SALDO.ToString();
                        tmpFac.descMaterial = resul.IT_F_VERIFICAR[i].TXZ01.ToString();
                        tmpFac.LIGHTS = resul.IT_F_VERIFICAR[i].LIGHTS.ToString();
                        tmpFac.posicion = resul.IT_F_VERIFICAR[i].POSICION.ToString();
                        tmpFac.tipoLinea = resul.IT_F_VERIFICAR[i].TIPOLINEA.ToString();
                        tmpFac.BWTAR = resul.IT_F_VERIFICAR[i].BWTAR.ToString();
                        tmpFac.cantidadXML = resul.IT_F_VERIFICAR[i].ZCOUNT;
                        tmpFac.MATNR = resul.IT_F_VERIFICAR[i].MATNR;
                        tmpFac.GJAHR = resul.IT_F_VERIFICAR[i].GJAHR;
                        if (resul.IT_F_VERIFICAR[i].KSCHL == null)
                        {
                            tmpFac.KSCHL = "";      
                        }
                        else
                        {
                            tmpFac.KSCHL = resul.IT_F_VERIFICAR[i].KSCHL.ToString();   
                        }
                        
                        tmpFac.BELNR = resul.IT_F_VERIFICAR[i].BELNR.ToString();
                        
                        if (resul.IT_F_VERIFICAR[i].MSG_VARIOS == null)
                        {
                            tmpFac.msgVarios = ""; 
                        }
                        else
                        {
                            tmpFac.msgVarios = resul.IT_F_VERIFICAR[i].MSG_VARIOS;
                        }

                        tmpFac.esPrimerCarga = false;
                        

                        lstResul.Add(tmpFac);
                    } // for result
                    srv.Close();

                } // try
                catch (Exception e)
                {
                    status[j] = "Error al cargar en la instancia: " + listaDiferentesInstancias[j][6];
                }

            } // for

            return lstResul;
        }
        
        /// <summary>
        /// Valida importe total, subtotal iva y moneda.
        /// </summary>
        /// <param name="listaDiferentesInstancias">endpoin, usuario y contraseña</param>
        /// <param name="fechafac">Fecha de factura</param>
        /// <param name="año">Año de documento</param>
        /// <param name="importe">Importe total</param>
        /// <param name="importeIVA">Importe de IVA</param>
        /// <param name="importeSub">Importe sin IVA</param>
        /// <param name="moneda">Tipo de Moneda</param>
        /// <param name="numerodoc">Numero de documento</param>
        /// <returns></returns>
        public string validardatosMir7(List<string[]> listaDiferentesInstancias, string fechafac, string año, decimal importe, decimal importeIVA, decimal importeSub, string moneda, string  numerodoc, string val_fec, string val_impt, string val_imps, string val_iva, string val_mon, decimal importedesc)
        {
            PEntidades.SrvSAPUProv.ZWS_UPROVEEDORESClient srv = new PPersistencia.WebServices().getZWS_UPROVEEDORESInstanceNew(
                    listaDiferentesInstancias[0][1].ToString().Trim(),
                    listaDiferentesInstancias[0][4].Split(new Char[] { ',' })
                    );

            PEntidades.SrvSAPUProv.Z_UFAC_VERIFMIR7 verimir7 = new PEntidades.SrvSAPUProv.Z_UFAC_VERIFMIR7();
            srv.Open();
            srv.InnerChannel.OperationTimeout = new TimeSpan(0, 10, 0);
            verimir7.FECHA_FACT = fechafac;
            verimir7.FISYEAR = año;
            verimir7.IMPORTE = importe;
            verimir7.IMPORTESpecified = true;
            verimir7.IMPORTE_IVA = importeIVA;
            verimir7.IMPORTE_IVASpecified = true;
            verimir7.IMPORTE_SUB = importeSub;
            verimir7.IMPORTE_SUBSpecified = true;
            verimir7.IMP_DESCUEN = importedesc;
            verimir7.IMP_DESCUENSpecified = true;
            verimir7.MONEDA = moneda;
            verimir7.NUM_DOC = numerodoc;
            verimir7.VAL_FECH_FACT = val_fec;
            verimir7.VAL_IMPORTE = val_impt;
            verimir7.VAL_IMP_IVA = val_iva;
            verimir7.VAL_IMP_SUB = val_imps;
            verimir7.VAL_MONEDA = val_mon;
            PEntidades.SrvSAPUProv.Z_UFAC_VERIFMIR7Response resul;
            resul = srv.Z_UFAC_VERIFMIR7(verimir7);
            srv.Close();
            return resul.MENSAJE;
        }
    }
}
