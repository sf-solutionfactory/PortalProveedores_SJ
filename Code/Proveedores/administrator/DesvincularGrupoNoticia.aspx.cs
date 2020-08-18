﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Proveedores.administrator
{
    public partial class DesvincularGrupoNoticia : System.Web.UI.Page
    {
        string buscar;
            
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.hidCerrarSesion.Value != "cerrar")
            {
            
            try
            {
                string[] resLog = null;
                resLog = (string[])Session["resLog"];
                //string sesion = Session["idUsuarioProveedor"].ToString().Trim();
                //if (sesion == "Admin")
                if (resLog[2].ToString() == "0")
                {

                }
                else
                {
                    cerrarSesion();
                }
            }
            catch (Exception)
            {
                cerrarSesion();
            }

            //INICIO mostrar mensaje en dialogo
            string dialog = "";
            try
            {
                dialog = Session["textoDialogo"].ToString();
                //if(){

                //}
                this.lblDialog.Text = dialog;
                Session["textoDialogo"] = "";
            }
            catch (Exception)
            {
                this.lblDialog.Text = "";
            }
            //FIN mostrar mensaje en dialogo

            BorrarDatosProveedor();
            if(!IsPostBack){
                
                try 
	            {
                    string toSee = Request.QueryString["toSee"];
                    if (toSee != null && toSee != "")
                    {
                        
                        llenarDatosProveedor(toSee);
                        buscarDetalleGrupo(toSee);   
                    }
                    else{
                        MostrarInformacion(this.chkModoDesvincular.Text);
                    }
	            }
	            catch (Exception)
	            {
                    MostrarInformacion(this.chkModoDesvincular.Text);
	            }
                
            }
            }
        }

        private void cerrarSesion()
        {
            //se borra la cookie de autenticacion
            System.Web.Security.FormsAuthentication.SignOut();
            //se redirecciona al usuario a la pagina de login
            Response.Redirect("config.aspx");
        }

        private void BorrarDatosProveedor() {
            this.lblDescribeNombre.Text = "";
            this.lblDescribeTituloGrupo.Text = "";
            this.lblNombreGrupo.Text = "";
            this.lblTItuloGrupoNoticia.Text = "";    
        }

        public void llenarDatosProveedor(string toSee) {
            List<string[]> lista = new PNegocio.Administrador.Noticia().consultarGrupoNoticiaPorId(toSee);

            this.lblDescribeNombre.Text = "Nombre del grupo: ";
            this.lblNombreGrupo.Text = lista[1][1];

            this.lblTextoExplicacion.Text = "<strong>Los siguientes proveedores estan ligados al grupo de noticia seeccionado:</strong>";
        }

        protected void MostrarInformacion(object sender, EventArgs e)
        {
            MostrarInformacion(this.chkModoDesvincular.Text);
        }

        public void MostrarInformacion(string buscar)
        {
            if (buscar == "Por proveedor")
            {
                this.lblMostrarTabla.Text = new PNegocio.Administrador.Proveedor().consultarProveedoresConNoticia("90%");
                if (this.lblMostrarTabla.Text != "<strong>No se encontraron resultados para mostrar en la tabla</strong>")
                {
                    this.lblTablaFiltro.Text = PNegocio.Administrador.TextoFiltro.textoTablaFiltro();
                    this.hidComplementoUr.Value = buscar;
                }
            }

            if (buscar == "Por grupo")
            {
                this.lblMostrarTabla.Text = new PNegocio.Administrador.Noticia().consultarGruposDeNoticia("90%");
                if (this.lblMostrarTabla.Text != "<strong>No se encontraron resultados para mostrar en la tabla</strong>")
                {
                    this.lblTablaFiltro.Text = PNegocio.Administrador.TextoFiltro.textoTablaFiltro();
                    this.hidComplementoUr.Value = buscar;
                }
            }    
        }



        private void buscarDetalleGrupo(string toSee) {
            this.lblMostrarTabla.Text = new PNegocio.Administrador.Noticia().consultarProveedorPorGrNoticia(toSee, "90%");
            if (this.lblMostrarTabla.Text != "<strong>No se encontraron resultados para mostrar en la tabla</strong>")
            {

                this.lblTablaFiltro.Text = PNegocio.Administrador.TextoFiltro.textoTablaFiltro();
                this.hidComplementoUr.Value = "Por proveedor" + ","+toSee;
            }
            else {
                this.lblMostrarTabla.Text = "<strong>Este grupo ya no tiene proveedores asignados</strong>";
                this.lblTextoExplicacion.Text = "";
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            MostrarInformacion(this.chkModoDesvincular.Text);
        }   


    }
}