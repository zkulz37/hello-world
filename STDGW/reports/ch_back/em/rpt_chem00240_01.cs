using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Drawing;
using NativeExcel;

public partial class rpt_chem00240_01 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
		ESysLib.SetUser(Session("APP_DBUSER"));


        string TemplateFile = "rpt_chem00240_01.xls";
        string TempFile = "../../../system/temp/rpt_chem00240_01_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file

        //'?p0=' + lstOrg_Code.value+'&p1='+lstWS.value+'&p2='+lstNation.value+'&p3='+txtTemp.text+'&p4='+lst_Approval.value+'&p5='+dtFromDate.value+'&p6='+dtToDate.value ;


        string p_thr_eva_master_pk, p_eva_group, p_self_confirm, p_manager_level, p_manager_confirm, p_emp, p_emp_search, p_m_level, p_m_search_by, p_m_tmp;

        p_thr_eva_master_pk = Request.QueryString["p0"];
        p_eva_group = Request.QueryString["p1"];
        p_self_confirm = Request.QueryString["p2"];
        p_manager_level = Request.QueryString["p3"];
        p_manager_confirm = Request.QueryString["p4"];
        p_emp = Request.QueryString["p5"];
        p_emp_search = Request.QueryString["p6"];
        p_m_level = Request.QueryString["p7"];
        p_m_search_by = Request.QueryString["p8"];
        p_m_tmp = Request.QueryString["p9"];
        


        string para = "'" + p_thr_eva_master_pk + "','" + p_eva_group + "','" + p_self_confirm + "','" + p_manager_level + "','" + p_manager_confirm + "','" + p_emp + "',";
        para += "'" + p_emp_search + "','" + p_m_level + "','" + p_m_search_by + "','" + p_m_tmp + "'";


        DataTable dt1;
        dt1 = ESysLib.TableReadOpenCursor("hr_rpt_chem00240_v2_01", para);


        int l_pos = 5;
        int l_rows = dt1.Rows.Count;
        int l_cols = dt1.Columns.Count;
      
        for (int i = 0; i < l_rows - 1; i++)
        {
            exSheet.Cells[l_pos + i + 1, 1].Rows.EntireRow.Insert();//insert row new of sheet

        }
        
        for (int i = 0; i < l_rows; i++)
        {

            exSheet.Cells[l_pos + i, 1].Value = i + 1;
            for (int j = 0; j < l_cols; j++)
            {
                exSheet.Cells[l_pos + i, j + 2].Value = dt1.Rows[i][j].ToString();
            }
        }


        
		
		//---------
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }
        // hide row firts 
      
        exBook.SaveAs(TempFile);
        //write out to client broswer
        System.IO.FileInfo file = new System.IO.FileInfo(TempFile);
        //System.IO.FileInfo file = new System.IO.FileInfo(pdfFilePath);
        Response.Clear();
        Response.Charset = "UTF-8";
        Response.ContentEncoding = System.Text.Encoding.UTF8;
        //Add header, give a default file name for "File Download/Store as"
        Response.AddHeader("Content-Disposition", "attachment; filename=" + Server.UrlEncode(file.Name));
        //Add header, set file size to enable browser display download progress
        Response.AddHeader("Content-Length", file.Length.ToString());
        //Set the return string is unavailable reading for client, and must be downloaded
        Response.ContentType = "application/ms-exSheet";
        //Response.ContentType = "application/pdf";
        //Send file string to client 
        //Response.WriteFile(pdfFilePath);
        Response.WriteFile(TempFile);
        //Stop execute  
        Response.End();

    }

    public Bitmap ResizeImage(Bitmap d, int w, int h)
    {
        Bitmap q = new Bitmap(w, h);
        float f, g;
        f = (float)w / (float)d.Width;
        g = (float)h / (float)d.Height;
        for (int i = 0; i < w; i++)
        {
            for (int j = 0; j < h; j++)
            {
                Color c;
                c = d.GetPixel((int)(i / f), (int)(j / g));
                q.SetPixel(i, j, c);
            }
        }
        return q;
    }
}