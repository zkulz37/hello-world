using System;
using System.Data;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Drawing;
using NativeExcel;
public partial class rpt_menu : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ESysLib.SetUser(Session["APP_DBUSER"].ToString());


        string TemplateFile = "rpt_menu.xls";
        string TempFile = "../../../system/temp/rpt_menu_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        string SQL
    = "SELECT MN.PK,MN.MENU_ID,MN.form_nm,MN.MN_LEVEL,MN.FORM_URL,MN.PARENT_ID,MN.PARENT_NM,MN.parent_pk " +
        "     FROM(select TF.PK PK,TF.MENU_ID,tf.form_nm, level MN_LEVEL,TF.FORM_URL " +
        "                ,(select a.menu_id from tes_obj a where a.del_if=0 and a.pk=tf.p_pk) parent_id " +
        "                ,(select a.form_nm from tes_obj a where a.del_if=0 and a.pk=tf.p_pk) parent_nm " +
        "                ,(select a.PK from tes_obj a where a.del_if=0 and a.pk=tf.p_pk) parent_pk " +
        "                                   from tes_obj tf " +
        "                                  where tf.del_if = 0  " +
        "                             start with TF.p_pk = 0 and tf.del_if = 0 and nvl(TF.USE_YN,'N')='Y' " +
        "                             connect by prior tf.pk = tf.p_pk " +
        "                              order siblings by no) MN ";



       // Response.Write(SQL);
        //Response.End();

        DataTable dt_emp = ESysLib.TableReadOpen(SQL);
        int irow,icol_emp;
        irow = dt_emp.Rows.Count;
        icol_emp = dt_emp.Columns.Count;
        if (irow == 0)
        {
            Response.Write("There is no data");
            Response.End();
        }    

        int i, j, k, i_allow;
        int pos = 3;
        
        for (i = 0; i < irow - 1; i++)
        {
            exSheet.Range[pos + i+1, 1].Rows.EntireRow.Insert();
        }

        //Show data
        for (i = 0; i < irow; i++)
        {
            exSheet.Cells[pos + i, 1].Value = i + 1;
            for (j = 0; j < icol_emp; j++)
                exSheet.Cells[pos + i, j+2].Value = dt_emp.Rows[i][j].ToString();
           
        }

        // end loop detail percent
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }



        // hide row firts 

        //range = exSheet.Range["A1"];
        // hide row A5 
        //range.Rows.Hidden = true;

        exBook.SaveAs(TempFile);
        //ESysLib.ExcelToPdf(TempFile);
        //string pdfFilePath = TempFile.Replace(".xls", ".pdf");

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
        Response.WriteFile(TempFile);
        //Response.WriteFile(pdfFilePath);
        //Stop execute  
        Response.End();
    }
}