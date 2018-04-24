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

public partial class reports_ch_cs_rpt_salary_pay_slip_pdf : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //ESysLib.SetUser("hr");
        ESysLib.SetUser(Session["APP_DBUSER"].ToString());

        string p_dept, p_group, p_status, p_type, p_pay_type, p_emp_id, p_work_mon, p_times, p_ct_type, p_from_leftdate, p_to_leftdate, p_m_type;

        p_dept = Request["l_dept"].ToString();
        p_group = Request["l_group"].ToString();
        p_status = Request["l_status"].ToString();
        p_type = Request["l_type"].ToString();
        p_pay_type = Request["l_pay_type"].ToString();
        p_emp_id = Request["l_emp_id"].ToString();
        p_work_mon = Request["l_work_mon"].ToString();
        p_times = Request["l_Times_r"].ToString();
        p_ct_type = Request["l_ct_type"].ToString();
        p_from_leftdate = Request["l_from_leftdate"].ToString();
        p_to_leftdate = Request["l_to_leftdate"].ToString();
        p_m_type = Request.QueryString["l_m_type"].ToString();

        string TemplateFile = "rpt_salary_pay_slip_pdf.xls";
        string TempFile = "../../../system/temp/rpt_salary_pay_slip_pdf_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        string para = "'" + p_dept + "','" + p_group + "','" + p_status + "','" + p_type + "','" + p_pay_type + "','" + p_emp_id + "','";
        para = para + p_work_mon + "','" + p_times + "','" + p_ct_type + "','" + p_m_type + "','" + p_from_leftdate + "','" + p_to_leftdate + "'";
        DataTable dt_emp = ESysLib.TableReadOpenCursor("hr_rpt_salary_pay_slip_pdf", para);

        if (dt_emp.Rows.Count == 0)
        {
            Response.Write("There is no data of salary.");
            Response.End();
        }

        string para_com = "'" + p_dept + "','" + p_work_mon + "'";
        DataTable dt_com = ESysLib.TableReadOpenCursor("hr_rpt_company", para_com);

        if (dt_com.Rows.Count == 0)
        {
            Response.Write("There is no data of company.");
            Response.End();
        }

        DataTable dt_allow = ESysLib.TableReadOpenCursor("hr_rpt_allowance_salary");

        DataTable dt_allow_k = ESysLib.TableReadOpenCursor("hr_rpt_allowance_k_salary");

        //Khai bao bien
        int i,j;
        int loop_row = 53;
        int r_allow = 10, r_allow_k = 28;
        //Insert new row

        for (i = 0; i < dt_emp.Rows.Count - 1; i++)
        {
            //exSheet.Range[2, 7, 54, 7].Rows.EntireRow.Insert();
            exSheet.Range[2, 1, 54, 7].Copy(exSheet.Range[55 + loop_row * i, 1, 107 + loop_row * i, 7], XlPasteType.xlPasteAll);
        }
        //Show data
        for (i = 0; i < dt_emp.Rows.Count; i++)
        {
            //insert picture
            if (dt_com.Rows[0][3].ToString() != "")
            {
                byte[] MyData = new byte[0];
                MyData = (byte[])dt_com.Rows[0][3];
                MemoryStream stream = new MemoryStream(MyData);

                Bitmap b = new Bitmap(stream);
                exSheet.Cells[2 + loop_row * i, 1].Select();
                exSheet.Shapes.AddPicture(ResizeImage(b, 75, 40));
            }
            exSheet.Cells[2 + loop_row * i, 1].Value = dt_com.Rows[0][0].ToString();
            exSheet.Cells[3 + loop_row * i, 1].Value = "PAY SLIP IN " + dt_com.Rows[0][4].ToString();
            exSheet.Cells[4 + loop_row * i, 1].Value = "PHIẾU LƯƠNG THÁNG " + dt_com.Rows[0][5].ToString();
            exSheet.Cells[5 + loop_row * i, 1].Value = "Họ tên: " + dt_emp.Rows[i]["full_nm"].ToString();
            exSheet.Cells[6 + loop_row * i, 2].Value = dt_emp.Rows[i]["emp_id"].ToString();
            exSheet.Cells[6 + loop_row * i, 6].Value = dt_emp.Rows[i]["dept_nm"].ToString();
            exSheet.Cells[7 + loop_row * i, 2].Value = dt_emp.Rows[i]["join_dt"].ToString();
            exSheet.Cells[7 + loop_row * i, 6].Value = dt_emp.Rows[i]["left_dt"].ToString();
            exSheet.Cells[9 + loop_row * i, 4].Value = Double.Parse(dt_emp.Rows[i]["sal_lev1"].ToString());
            exSheet.Cells[9 + loop_row * i, 6].Value = Double.Parse(dt_emp.Rows[i]["sal_lev2"].ToString());
            for (j = 0; j < 8; j++)
            {
                exSheet.Cells[10 + j + loop_row * i, 1].Value = dt_allow.Rows[0][16 + j].ToString();
                exSheet.Cells[10 + j + loop_row * i, 2].Value = "(" + dt_allow.Rows[0][j].ToString() + ")";
                exSheet.Cells[10 + j + loop_row * i, 4].Value = Double.Parse(dt_emp.Rows[i][9 + j].ToString());
                exSheet.Cells[10 + j + loop_row * i, 6].Value = Double.Parse(dt_emp.Rows[i][17 + j].ToString());
            }
            exSheet.Cells[19 + loop_row * i, 4].Value = Double.Parse(dt_emp.Rows[i]["wd_l1"].ToString());
            exSheet.Cells[19 + loop_row * i, 5].Value = Double.Parse(dt_emp.Rows[i]["wd_l2"].ToString());
            exSheet.Cells[19 + loop_row * i, 7].Value = Double.Parse(dt_emp.Rows[i]["wd_amt"].ToString());
            exSheet.Cells[20 + loop_row * i, 4].Value = Double.Parse(dt_emp.Rows[i]["abs_ale_l1"].ToString());
            exSheet.Cells[20 + loop_row * i, 5].Value = Double.Parse(dt_emp.Rows[i]["abs_ale_l2"].ToString());
            exSheet.Cells[20 + loop_row * i, 7].Value = Double.Parse(dt_emp.Rows[i]["abs_ale_amt"].ToString());
            exSheet.Cells[21 + loop_row * i, 4].Value = Double.Parse(dt_emp.Rows[i]["abs_other_l1"].ToString());
            exSheet.Cells[21 + loop_row * i, 5].Value = Double.Parse(dt_emp.Rows[i]["abs_other_l2"].ToString());
            exSheet.Cells[21 + loop_row * i, 7].Value = Double.Parse(dt_emp.Rows[i]["abs_other_amt"].ToString());
            exSheet.Cells[22 + loop_row * i, 4].Value = Double.Parse(dt_emp.Rows[i]["ot_l1"].ToString());
            exSheet.Cells[22 + loop_row * i, 5].Value = Double.Parse(dt_emp.Rows[i]["ot_l2"].ToString());
            exSheet.Cells[22 + loop_row * i, 7].Value = Double.Parse(dt_emp.Rows[i]["ot_amt"].ToString());
            exSheet.Cells[23 + loop_row * i, 4].Value = Double.Parse(dt_emp.Rows[i]["ot_hol_l1"].ToString());
            exSheet.Cells[23 + loop_row * i, 5].Value = Double.Parse(dt_emp.Rows[i]["ot_hol_l2"].ToString());
            exSheet.Cells[23 + loop_row * i, 7].Value = Double.Parse(dt_emp.Rows[i]["ot_hol_amt"].ToString());
            exSheet.Cells[24 + loop_row * i, 4].Value = Double.Parse(dt_emp.Rows[i]["nt30_l1"].ToString());
            exSheet.Cells[24 + loop_row * i, 5].Value = Double.Parse(dt_emp.Rows[i]["nt30_l2"].ToString());
            exSheet.Cells[24 + loop_row * i, 7].Value = Double.Parse(dt_emp.Rows[i]["nt30_amt"].ToString());
            exSheet.Cells[25 + loop_row * i, 4].Value = Double.Parse(dt_emp.Rows[i]["nt45_l1"].ToString());
            exSheet.Cells[25 + loop_row * i, 5].Value = Double.Parse(dt_emp.Rows[i]["nt45_l2"].ToString());
            exSheet.Cells[25 + loop_row * i, 7].Value = Double.Parse(dt_emp.Rows[i]["nt45_amt"].ToString());
            exSheet.Cells[26 + loop_row * i, 4].Value = Double.Parse(dt_emp.Rows[i]["nt60_l1"].ToString());
            exSheet.Cells[26 + loop_row * i, 5].Value = Double.Parse(dt_emp.Rows[i]["nt60_l2"].ToString());
            exSheet.Cells[26 + loop_row * i, 7].Value = Double.Parse(dt_emp.Rows[i]["nt60_amt"].ToString());
            exSheet.Cells[27 + loop_row * i, 4].Value = Double.Parse(dt_emp.Rows[i]["nt90_l1"].ToString());
            exSheet.Cells[27 + loop_row * i, 5].Value = Double.Parse(dt_emp.Rows[i]["nt90_l2"].ToString());
            exSheet.Cells[27 + loop_row * i, 7].Value = Double.Parse(dt_emp.Rows[i]["nt90_amt"].ToString());
            for (j = 0; j < 8; j++)
            {
                exSheet.Cells[28 + j + loop_row * i, 1].Value = dt_allow_k.Rows[0][8 + j].ToString();
                exSheet.Cells[28 + j + loop_row * i, 2].Value = "(" + dt_allow_k.Rows[0][j].ToString() + ")";
                exSheet.Cells[28 + j + loop_row * i, 7].Value = Double.Parse(dt_emp.Rows[i][52 + j].ToString());
            }
            exSheet.Cells[36 + loop_row * i, 7].Value = Double.Parse(dt_emp.Rows[i]["return_amt"].ToString());
            exSheet.Cells[37 + loop_row * i, 7].Value = Double.Parse(dt_emp.Rows[i]["inc_amt"].ToString());
            exSheet.Cells[38 + loop_row * i, 4].Value = Double.Parse(dt_emp.Rows[i]["ale_stop"].ToString());
            exSheet.Cells[38 + loop_row * i, 7].Value = Double.Parse(dt_emp.Rows[i]["ale_stop_amt"].ToString());
            exSheet.Cells[39 + loop_row * i, 4].Value = Double.Parse(dt_emp.Rows[i]["severance"].ToString());
            exSheet.Cells[39 + loop_row * i, 7].Value = Double.Parse(dt_emp.Rows[i]["severance_amt"].ToString());
            exSheet.Cells[40 + loop_row * i, 4].Value = Double.Parse(dt_emp.Rows[i]["gross_amt"].ToString());
            exSheet.Cells[41 + loop_row * i, 4].Value = Double.Parse(dt_emp.Rows[i]["break_day"].ToString());
            exSheet.Cells[41 + loop_row * i, 7].Value = Double.Parse(dt_emp.Rows[i]["break_day_amt"].ToString());
            exSheet.Cells[42 + loop_row * i, 4].Value = Double.Parse(dt_emp.Rows[i]["social_amt"].ToString());
            exSheet.Cells[43 + loop_row * i, 4].Value = Double.Parse(dt_emp.Rows[i]["health_amt"].ToString());
            exSheet.Cells[44 + loop_row * i, 4].Value = Double.Parse(dt_emp.Rows[i]["unemp_amt"].ToString());
            exSheet.Cells[45 + loop_row * i, 4].Value = Double.Parse(dt_emp.Rows[i]["advance_amt"].ToString());
            exSheet.Cells[46 + loop_row * i, 7].Value = Double.Parse(dt_emp.Rows[i]["ot_100_amt"].ToString());
            exSheet.Cells[47 + loop_row * i, 7].Value = Double.Parse(dt_emp.Rows[i]["deduct_pit"].ToString());
            exSheet.Cells[48 + loop_row * i, 7].Value = Double.Parse(dt_emp.Rows[i]["income_befo"].ToString());
            exSheet.Cells[49 + loop_row * i, 7].Value = Double.Parse(dt_emp.Rows[i]["income_tax"].ToString());
            exSheet.Cells[50 + loop_row * i, 4].Value = Double.Parse(dt_emp.Rows[i]["union_amt"].ToString());
            exSheet.Cells[51 + loop_row * i, 4].Value = Double.Parse(dt_emp.Rows[i]["return_no_pit"].ToString());
            exSheet.Cells[52 + loop_row * i, 4].Value = Double.Parse(dt_emp.Rows[i]["advance_no_pit"].ToString());
            exSheet.Cells[53 + loop_row * i, 4].Value = Double.Parse(dt_emp.Rows[i]["net_amt"].ToString());
            //Insert page break
            IPageBreaks pbs = exBook.Worksheets[1].HPageBreaks;
            IRange usedrange = exBook.Worksheets[1].UsedRange;
            //pbs.Reset();
            pbs.Add(usedrange.Rows[53 + loop_row*i]);
            //end insert page beak

            //Hide allowance row allowance
            for (j = 0; j < 8; j++)
            {
                if (dt_allow.Rows[0][j + 8].ToString() != "1")
                    exSheet.Range[r_allow + j + loop_row * i, 1].Rows.Hidden = true;

                if (dt_allow_k.Rows[0][j].ToString() == "")
                    exSheet.Range[r_allow_k + j + loop_row * i, 1].Rows.Hidden = true;
            }
        }

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