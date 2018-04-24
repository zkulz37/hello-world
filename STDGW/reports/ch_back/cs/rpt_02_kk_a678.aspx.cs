using System;
using System.Data;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Drawing;
using NativeExcel;

public partial class reports_ch_cs_rpt_02_kk_a678 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ESysLib.SetUser("hr");

        string p_dept, p_group, p_status, p_type, p_pay_type, p_emp_id, p_work_mon, p_m_type;
        string p_mm, p_yy;

        p_dept = Request["l_dept"].ToString();
        p_group = Request["l_group"].ToString();
        p_status = Request["l_status"].ToString();
        p_type = Request["l_type"].ToString();
        p_pay_type = Request["l_pay_type"].ToString();
        p_emp_id = Request["l_emp_id"].ToString();
        p_work_mon = Request["l_work_mon"].ToString();
        p_m_type = Request.QueryString["l_m_type"].ToString();

        string TemplateFile = "rpt_02_kk_a678.xls";
        string TempFile = "../../../system/temp/rpt_02_kk_a678_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        string para_com = "'" + p_work_mon + "','" + p_dept + "'";
        DataTable dt_com = ESysLib.TableReadOpenCursor("hr.sp_rpt_02_kk_a678_com", para_com);

        string para = "'" + p_work_mon + "','" + p_dept + "','" + p_group + "','" + p_emp_id + "','" + p_status + "','" + p_pay_type + "','" + p_m_type + "'";
        DataTable dt_emp = ESysLib.TableReadOpenCursor("hr.sp_rpt_02_kk_a678", para);

        p_mm = p_work_mon.Substring(4, 2).ToString();
        p_yy = p_work_mon.Substring(0, 4).ToString();
        
        //bind data to excel file
        //-----header---   
        exSheet.Cells["A1"].Value = "";
        exSheet.Cells["K4"].Value = "Kỳ tính thuế: Tháng " + p_mm + " năm " + p_yy;
        exSheet.Cells["I6"].Value = dt_com.Rows[0][6].ToString();   //Ma so thue
        exSheet.Cells["I7"].Value = dt_com.Rows[0][0].ToString();   //Ten nguoi nop thue
        //---end--header---
       
        exSheet.Cells["U12"].Value = Double.Parse(dt_emp.Rows[0][0].ToString());  //21
        exSheet.Cells["U13"].Value = Double.Parse(dt_emp.Rows[0][0].ToString());  //22
        exSheet.Cells["U14"].Value = 0;                             //23
        exSheet.Cells["U15"].Value = Double.Parse(dt_emp.Rows[0][1].ToString());  //24
        exSheet.Cells["U16"].Value = Double.Parse(dt_emp.Rows[0][2].ToString());  //25
        exSheet.Cells["U17"].Value = Double.Parse(dt_emp.Rows[0][3].ToString());  //26
        exSheet.Cells["U18"].Value = 0;                             //27
        exSheet.Cells["U19"].Value = Double.Parse(dt_emp.Rows[0][4].ToString());  //28
        exSheet.Cells["U20"].Value = Double.Parse(dt_emp.Rows[0][5].ToString());  //29
        exSheet.Cells["U21"].Value = Double.Parse(dt_emp.Rows[0][6].ToString());  //30
        exSheet.Cells["U22"].Value = 0;                             //31
        exSheet.Cells["U23"].Value = Double.Parse(dt_emp.Rows[0][7].ToString());  //32
        exSheet.Cells["U24"].Value = Double.Parse(dt_emp.Rows[0][8].ToString());  //33
        exSheet.Cells["U25"].Value = Double.Parse(dt_emp.Rows[0][9].ToString());  //34
        exSheet.Cells["U26"].Value = 0;                             //35    
        
            //--set-----DataBind--in---Master---



            ////end-set-----DataBind--in---Master---




            //-----------------------------end------can-----bang-------page-----------
            // end loop detail not percent

            // end loop detail percent
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }


        // hide row firts 

        range = exSheet.Range["A1"];
        // hide row A5 
        range.Rows.Hidden = true;

        exBook.SaveAs(TempFile);
        //write out to client broswer
        System.IO.FileInfo file = new System.IO.FileInfo(TempFile);
        Response.Clear();
        Response.Charset = "UTF-8";
        Response.ContentEncoding = System.Text.Encoding.UTF8;
        //Add header, give a default file name for "File Download/Store as"
        Response.AddHeader("Content-Disposition", "attachment; filename=" + Server.UrlEncode(file.Name));
        //Add header, set file size to enable browser display download progress
        Response.AddHeader("Content-Length", file.Length.ToString());
        //Set the return string is unavailable reading for client, and must be downloaded
        Response.ContentType = "application/ms-exSheet";
        //Send file string to client 
        Response.WriteFile(TempFile);
        //Stop execute  
        Response.End();
    }
}