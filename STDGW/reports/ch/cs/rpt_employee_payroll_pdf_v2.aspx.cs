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

public partial class reports_ch_cs_rpt_employee_payroll_pdf_v2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //ESysLib.SetUser("hr");
        ESysLib.SetUser(Session["APP_DBUSER"].ToString());

        string p_dept, p_group, p_status, p_type, p_pay_type, p_emp_id, p_work_mon, p_m_type, p_times, p_ct_type, p_from_leftdate, p_to_leftdate;

        p_dept = Request["l_dept"].ToString();
        p_group = Request["l_group"].ToString();
        p_status = Request["l_status"].ToString();
        p_type = Request["l_type"].ToString();
        p_pay_type = Request["l_pay_type"].ToString();
        p_emp_id = Request["l_emp_id"].ToString();
        p_work_mon = Request["l_work_mon"].ToString();
        p_times = Request["l_Times_r"].ToString();
        p_ct_type = Request["l_ct_type"].ToString();
        p_m_type = Request.QueryString["l_m_type"].ToString();
        p_from_leftdate = Request["l_from_leftdate"].ToString();
        p_to_leftdate = Request["l_to_leftdate"].ToString();

        string TemplateFile = "rpt_employee_payroll_pdf_v2.xls";
        string TempFile = "../../../system/temp/rpt_employee_payroll_pdf_v2_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        string para = "'" + p_dept + "','" + p_group + "','" + p_status + "','" + p_type + "','" + p_pay_type + "','" + p_emp_id + "','";
        para = para + p_work_mon + "','" + p_times + "','" + p_ct_type + "','" + p_m_type + "','" + p_from_leftdate + "','" + p_to_leftdate + "'";
        DataTable dt_emp = ESysLib.TableReadOpenCursor("hr_rpt_employee_payroll_pdf_v2", para);

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

        int i, j, k, i_allow;
        int pos = 7, total_col = 78;
        int allow_l1 = 11, allow_l2 = 22, allow_k = 51, confirm_dt = 19;     //vi tri phu cap
        int emp_dept = 0, n_dept = 0;
        Double[] sub_total = new Double[total_col];
        Double[] grant_total = new Double[total_col];

        //bind data to excel file
        //-----header---   
        exSheet.Cells[1, 1].Select();
        exSheet.Cells["C1"].Value = dt_com.Rows[0][0].ToString();
        exSheet.Cells["C2"].Value = dt_com.Rows[0][1].ToString();
        exSheet.Cells["C3"].Value = "Phone: " + dt_com.Rows[0][2].ToString();
        exSheet.Cells["AJ1"].Value = "EMPLOYEE'S PAYROLL IN " + dt_com.Rows[0][4].ToString();
        exSheet.Cells["AJ2"].Value = "BẢNG LƯƠNG NHÂN VIÊN THÁNG " + dt_com.Rows[0][5].ToString();
        for (i_allow = 0; i_allow < 8; i_allow++)
        {
            if (dt_allow.Rows[0][i_allow + 8].ToString() == "1")
            {
                exSheet.Cells[5, allow_l1 + i_allow].Value = dt_allow.Rows[0][i_allow].ToString();
                exSheet.Cells[6, allow_l1 + i_allow].Value = dt_allow.Rows[0][16 + i_allow].ToString();

                exSheet.Cells[5, allow_l2 + i_allow].Value = dt_allow.Rows[0][i_allow].ToString();
                exSheet.Cells[6, allow_l2 + i_allow].Value = dt_allow.Rows[0][16 + i_allow].ToString();
            }

            if (dt_allow_k.Rows[0][i_allow].ToString() != "")
            {
                exSheet.Cells[4, allow_k + i_allow].Value = dt_allow_k.Rows[0][i_allow].ToString();
                exSheet.Cells[5, allow_k + i_allow].Value = dt_allow_k.Rows[0][i_allow + 8].ToString();
            }
        }

        //insert picture
        if (dt_com.Rows[0][3].ToString() != "")
        {
            byte[] MyData = new byte[0];
            MyData = (byte[])dt_com.Rows[0][3];
            MemoryStream stream = new MemoryStream(MyData);

            Bitmap b = new Bitmap(stream);

            exSheet.Shapes.AddPicture(ResizeImage(b, 115, 85));
        }
        //---end--header---

        for (k = 0; k < total_col; k++)
        {
            sub_total[k] = 0;
            grant_total[k] = 0;
        }

        for (i = 0; i < dt_emp.Rows.Count - 1; i++)
        {
            j = i + 1;
            if (dt_emp.Rows[i][0].ToString() != dt_emp.Rows[j][0].ToString())
                n_dept++;
        }

        //Insert new row

        for (i = 0; i < dt_emp.Rows.Count - 1 + n_dept; i++)
        {
            exSheet.Range[pos + 1, 1].Rows.EntireRow.Insert();
        }

        //Show data
        for (i = 0; i < dt_emp.Rows.Count; i++)
        {
            for (k = 9; k < 78; k++)
            {
                if (k == 18 || k == 19)
                    continue;
                sub_total[k] = sub_total[k] + Double.Parse(dt_emp.Rows[i][k].ToString());
                grant_total[k] = grant_total[k] + Double.Parse(dt_emp.Rows[i][k].ToString());
                
            }       
            emp_dept++;

            exSheet.Cells[pos + i, 1].Value = emp_dept;
            exSheet.Cells[pos + i, 2].Value = dt_emp.Rows[i][1].ToString();             //dept
            exSheet.Cells[pos + i, 3].Value = dt_emp.Rows[i][2].ToString();             //emp_id
            exSheet.Cells[pos + i, 4].Value = dt_emp.Rows[i][3].ToString();             //name
            exSheet.Cells[pos + i, 5].Value = dt_emp.Rows[i][4].ToString();             //join_dt
            exSheet.Cells[pos + i, 6].Value = dt_emp.Rows[i][5].ToString();             //left date
            exSheet.Cells[pos + i, 7].Value = dt_emp.Rows[i][6].ToString();             //position
            exSheet.Cells[pos + i, 8].Value = dt_emp.Rows[i][7].ToString();             //times 
            for (j = 0; j < 70; j++)
            {
                if (j == 0 || j == 10 || j == 11)
                    exSheet.Cells[pos + i, 9 + j].Value = dt_emp.Rows[i][8 + j].ToString();
                else
                    exSheet.Cells[pos + i, 9 + j].Value = Double.Parse(dt_emp.Rows[i][8 + j].ToString());
            }

          
            
            if (i != dt_emp.Rows.Count - 1 && (dt_emp.Rows[i][0].ToString() != dt_emp.Rows[i + 1][0].ToString()))
            {
                exSheet.Cells[pos + i + 1, 1, pos + i + 1, 4].Merge();
                exSheet.Cells[pos + i + 1, 1].Value = "Total " + dt_emp.Rows[i][1].ToString() + " (" + emp_dept + " employees)";
                exSheet.Cells[pos + i + 1, 1, pos + i + 1, 68].Rows.Font.Bold = true;
                for (k = 9; k < total_col; k++)
                {
                    exSheet.Cells[pos + i + 1, k + 1].Value = sub_total[k];
                    sub_total[k] = 0;
                    
                    exSheet.Cells[pos + i + 1, confirm_dt].Value = "";      //confirm date
                    exSheet.Cells[pos + i + 1, confirm_dt + 1].Value = "";  //grade 2
                }
                //Insert page break
                IPageBreaks pbs = exBook.Worksheets[1].HPageBreaks;
                IRange usedrange = exBook.Worksheets[1].UsedRange;
                //pbs.Reset();
                pbs.Add(usedrange.Rows[pos + i + 2]);
                //end insert page beak      
                pos = pos + 1;
                emp_dept = 0;
            }
            else if (i == dt_emp.Rows.Count - 1)
            {
                exSheet.Cells[pos + i + 1, 1, pos + i + 1, 4].Merge();
                exSheet.Cells[pos + i + 1, 1].Value = "Total " + dt_emp.Rows[i][1].ToString() + ": " + emp_dept + " employee(s)";
                exSheet.Cells[pos + i + 1, 1, pos + i + 1, 78].Rows.Font.Bold = true;
                exSheet.Cells[pos + i + 2, 1, pos + i + 2, 4].Merge();
                exSheet.Cells[pos + i + 2, 1].Value = "Grant Total: " + dt_emp.Rows.Count + " employee(s)";
                exSheet.Cells[pos + i + 2, 1, pos + i + 2, 78].Rows.Font.Bold = true;
                for (k = 9; k < total_col; k++)
                {
                    exSheet.Cells[pos + i + 1, k + 1].Value = sub_total[k];
                    exSheet.Cells[pos + i + 2, k + 1].Value = grant_total[k];
                    
                    exSheet.Cells[pos + i + 1, confirm_dt].Value = "";      //confirm date
                    exSheet.Cells[pos + i + 1, confirm_dt + 1].Value = "";  //grade 2
                    exSheet.Cells[pos + i + 2, confirm_dt].Value = "";      //confirm date
                    exSheet.Cells[pos + i + 2, confirm_dt + 1].Value = "";  //grade 2
                }
            }
            
        }
        //Hide allowance column
        for (i_allow = 0; i_allow < 8; i_allow++)
        {
            if (dt_allow.Rows[0][i_allow + 8].ToString() != "1")
            {
                exSheet.Range[1, allow_l1 + i_allow].Columns.Hidden = true;
                exSheet.Range[1, allow_l2 + i_allow].Columns.Hidden = true;
            }

            if (dt_allow_k.Rows[0][i_allow].ToString() == "")
                exSheet.Range[1, allow_k + i_allow].Columns.Hidden = true;
        }
        
        // end loop detail percent
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }


        // hide row not use 
        
        if (dt_com.Rows[0][6].ToString() == "OAC")      // On accessories
        {
            exSheet.Range[1, 8].Columns.Hidden = true;      //times
            for(int ii = 41; ii <= 48; ii++) 
                exSheet.Range[1, ii].Columns.Hidden = true;      //NT
            exSheet.Range[1, 50].Columns.Hidden = true;      //OT 100%
            exSheet.Range[1, 63].Columns.Hidden = true;      //Severance
            exSheet.Range[1, 64].Columns.Hidden = true;      //Severance amt
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