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

public partial class reports_fp_fa_rpt_fpfa00480 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ESysLib.SetUser(Session["APP_DBUSER"].ToString());

        string TemplateFile = "rpt_fpfa00480.xls";
        string TempFile = "../../../system/temp/rpt_fpfa00480_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];
        string p_date = "";
        string para = "'" + p_date + "'";
        DataTable dt = ESysLib.TableReadOpenCursor("lg_rpt_fpfa00480", para);
        //truong hop dt ko co du lieu
        dt.Rows.Add();
        exSheet.Range["B5"].Value = "Project Name : " + dt.Rows[0]["Pro_nm"].ToString();
        exSheet.Range["B6"].Value = "Construction of Kind : " + dt.Rows[0]["const_kd"].ToString();
        exSheet.Range["B7"].Value = "Manufacture Factory : " + dt.Rows[0]["manu_fac"].ToString();
        exSheet.Range["C8"].Value = dt.Rows[0]["report_dt"].ToString();
        exSheet.Range["K6"].Value = dt.Rows[0]["drawn_by"].ToString();
        exSheet.Range["K8"].Value = dt.Rows[0]["weather"].ToString();

        exSheet.Range["D12"].Value = dt.Rows[0]["att01"].ToString();
        exSheet.Range["E12"].Value = dt.Rows[0]["att02"].ToString();
        exSheet.Range["F12"].Value = dt.Rows[0]["att03"].ToString();
        exSheet.Range["G12"].Value = dt.Rows[0]["att04"].ToString();
        exSheet.Range["H12"].Value = dt.Rows[0]["att05"].ToString();
        exSheet.Range["I12"].Value = dt.Rows[0]["att06"].ToString();
        exSheet.Range["J12"].Value = dt.Rows[0]["att07"].ToString();
        exSheet.Range["K12"].Value = dt.Rows[0]["att08"].ToString();
        exSheet.Range["L12"].Value = dt.Rows[0]["att09"].ToString();
        exSheet.Range["M12"].Value = dt.Rows[0]["total1"].ToString();

        exSheet.Range["D13"].Value = dt.Rows[0]["btt01"].ToString();
        exSheet.Range["E13"].Value = dt.Rows[0]["btt02"].ToString();
        exSheet.Range["F13"].Value = dt.Rows[0]["btt03"].ToString();
        exSheet.Range["G13"].Value = dt.Rows[0]["btt04"].ToString();
        exSheet.Range["H13"].Value = dt.Rows[0]["btt05"].ToString();
        exSheet.Range["I13"].Value = dt.Rows[0]["btt06"].ToString();
        exSheet.Range["J13"].Value = dt.Rows[0]["btt07"].ToString();
        exSheet.Range["K13"].Value = dt.Rows[0]["btt08"].ToString();
        exSheet.Range["L13"].Value = dt.Rows[0]["btt09"].ToString();
        exSheet.Range["M13"].Value = dt.Rows[0]["total2"].ToString();

        exSheet.Range["D14"].Value = dt.Rows[0]["stot1"].ToString();
        exSheet.Range["E14"].Value = dt.Rows[0]["stot2"].ToString();
        exSheet.Range["F14"].Value = dt.Rows[0]["stot3"].ToString();
        exSheet.Range["G14"].Value = dt.Rows[0]["stot4"].ToString();
        exSheet.Range["H14"].Value = dt.Rows[0]["stot5"].ToString();
        exSheet.Range["I14"].Value = dt.Rows[0]["stot6"].ToString();
        exSheet.Range["J14"].Value = dt.Rows[0]["stot7"].ToString();
        exSheet.Range["K14"].Value = dt.Rows[0]["stot8"].ToString();
        exSheet.Range["L14"].Value = dt.Rows[0]["stot9"].ToString();
        exSheet.Range["M14"].Value = dt.Rows[0]["stot10"].ToString();
        // DETAIL
        para = "'" + Request["master_pk"] + "'";
        DataTable dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_fpfa00480_1", para);
        for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count * 5; l_addrow++)
        {
            exSheet.Range["A19"].Rows.EntireRow.Insert();//insert row new of sheet
        }

        int p_row = 18, p_col = 1;
        string p_title = string.Empty;

        exSheet.Cells[p_row, 1, p_row + (dtDetail.Rows.Count * 5), 1].Merge();
        for (int l_row = 0; l_row < dtDetail.Rows.Count; l_row++)
        {
            exSheet.Cells[p_row + (l_row * 5), 2, p_row + (l_row * 5) + 4, 2].Merge();
            exSheet.Cells[p_row + (l_row * 5), 3, p_row + (l_row * 5) + 4, 3].Merge();
            for (int i = 0; i < 5; i++)
            {
                switch (i)
                {
                    case 0:
                        p_title = "Fit up";
                        break;
                    case 1:
                        p_title = "Welding";
                        break;
                    case 2:
                        p_title = "Inspection";
                        break;
                    case 3:
                        p_title = "Painting";
                        break;
                    case 4:
                        p_title = "Delivery";
                        break;
                }
                exSheet.Cells[p_row + (l_row * 5) + i, p_col].Value = dtDetail.Rows[l_row]["h_name"].ToString();
                exSheet.Cells[p_row + (l_row * 5) + i, p_col + 1].Value = dtDetail.Rows[l_row]["zone_id"].ToString();
                exSheet.Cells[p_row + (l_row * 5) + i, p_col + 2].Value = dtDetail.Rows[l_row]["lot"].ToString();
                
                exSheet.Cells[p_row + (l_row * 5) + i, p_col + 3].Value = p_title;
                exSheet.Cells[p_row + (l_row * 5) + i, p_col + 4].Value = dtDetail.Rows[l_row]["fu_de_qty"].ToString();
                exSheet.Cells[p_row + (l_row * 5) + i, p_col + 5].Value = dtDetail.Rows[l_row]["fu_de_wgt"].ToString();
                exSheet.Cells[p_row + (l_row * 5) + i, p_col + 6].Value = dtDetail.Rows[l_row]["fu_acc_qty"].ToString();
                exSheet.Cells[p_row + (l_row * 5) + i, p_col + 7].Value = dtDetail.Rows[l_row]["fu_acc_wgt"].ToString();
                exSheet.Cells[p_row + (l_row * 5) + i, p_col + 8].Value = dtDetail.Rows[l_row]["fu_td_qty"].ToString();
                exSheet.Cells[p_row + (l_row * 5) + i, p_col + 9].Value = dtDetail.Rows[l_row]["fu_td_wgt"].ToString();
                exSheet.Cells[p_row + (l_row * 5) + i, p_col + 10].Value = dtDetail.Rows[l_row]["fu_sum_qty"].ToString();
                exSheet.Cells[p_row + (l_row * 5) + i, p_col + 11].Value = dtDetail.Rows[l_row]["fu_sum_wgt"].ToString();
            }
        }

        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }

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
