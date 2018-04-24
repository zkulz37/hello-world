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

public partial class reports_ch_cs_rpt_employee_payroll_pdf : System.Web.UI.Page
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
        p_ct_type = Request["l_CT_Type"].ToString();
        p_m_type = Request.QueryString["l_m_type"].ToString();
        p_from_leftdate = Request["l_from_leftdate"].ToString();
        p_to_leftdate = Request["l_to_leftdate"].ToString();

        string TemplateFile = "rpt_employee_payroll_pdf.xls";
        string TempFile = "../../../system/temp/rpt_employee_payroll_pdf_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        string para = "'" + p_dept + "','" + p_group + "','" + p_status + "','" + p_type + "','" + p_pay_type + "','" + p_emp_id + "','";
        para = para + p_work_mon + "','" + p_times + "','" + p_ct_type + "','" + p_m_type + "','" + p_from_leftdate + "','" + p_to_leftdate + "'";
        DataTable dt_emp = ESysLib.TableReadOpenCursor("hr_rpt_employee_payroll_pdf", para);

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
        int pos=7;
        int allow = 11, allow_k = 40;     //vi tri phu cap
        int emp_dept = 0, n_dept = 0;
        Double[] sub_total = new Double[59]; 
        Double[] grant_total = new Double[59];
        
        //bind data to excel file
        //-----header---   
        exSheet.Cells[2, 1].Select();
        exSheet.Cells["A1"].Value = "";
        exSheet.Cells["C2"].Value = dt_com.Rows[0][0].ToString();
        exSheet.Cells["C3"].Value = dt_com.Rows[0][1].ToString();
        exSheet.Cells["C4"].Value = "Phone: " + dt_com.Rows[0][2].ToString();
        exSheet.Cells["AD2"].Value = "EMPLOYEE'S PAYROLL IN " + dt_com.Rows[0][4].ToString();
        exSheet.Cells["AD3"].Value = "BẢNG LƯƠNG NHÂN VIÊN THÁNG " + dt_com.Rows[0][5].ToString();
        for (i_allow = 0; i_allow < 8; i_allow++)
        {
            if (dt_allow.Rows[0][i_allow + 8].ToString() == "1")
            {
                exSheet.Cells[5, allow + i_allow].Value = dt_allow.Rows[0][i_allow].ToString();
                exSheet.Cells[6, allow + i_allow].Value = dt_allow.Rows[0][16 + i_allow].ToString();
            }

            if (dt_allow_k.Rows[0][i_allow].ToString() != "")
            {
                exSheet.Cells[5, allow_k + i_allow].Value = dt_allow_k.Rows[0][i_allow].ToString();
                exSheet.Cells[6, allow_k + i_allow].Value = dt_allow_k.Rows[0][i_allow + 8].ToString();
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
        
        for (k = 0; k < 59; k++)
        {
            sub_total[k] = 0;
            grant_total[k] = 0;
        }
        
        for (i = 0; i < dt_emp.Rows.Count-1; i++)
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
            for(k = 0; k < 59; k++)
            {
                sub_total[k] = sub_total[k] + Double.Parse(dt_emp.Rows[i][7 + k].ToString());
                grant_total[k] = grant_total[k] + Double.Parse(dt_emp.Rows[i][7 + k].ToString());
            }
            emp_dept++;
            
            exSheet.Cells[pos + i, 1].Value = emp_dept;
            exSheet.Cells[pos + i, 2].Value = dt_emp.Rows[i][1].ToString();             //dept
            exSheet.Cells[pos + i, 3].Value = dt_emp.Rows[i][2].ToString();             //emp_id
            exSheet.Cells[pos + i, 4].Value = dt_emp.Rows[i][3].ToString();             //name
            exSheet.Cells[pos + i, 5].Value = dt_emp.Rows[i][4].ToString();             //join_dt
            exSheet.Cells[pos + i, 6].Value = dt_emp.Rows[i][5].ToString();             //left date
            exSheet.Cells[pos + i, 7].Value = dt_emp.Rows[i][6].ToString();             //position
            exSheet.Cells[pos + i, 8].Value = dt_emp.Rows[i][74].ToString();             //times 
            exSheet.Cells[pos + i, 9].Value = Double.Parse(dt_emp.Rows[i][7].ToString());             //sal level 1
            exSheet.Cells[pos + i, 10].Value = Double.Parse(dt_emp.Rows[i][8].ToString());             //sal level 2
            exSheet.Cells[pos + i, 11].Value = Double.Parse(dt_emp.Rows[i][9].ToString());             //allow_amt1
            exSheet.Cells[pos + i, 12].Value = Double.Parse(dt_emp.Rows[i][10].ToString());             //allow_amt2
            exSheet.Cells[pos + i, 13].Value = Double.Parse(dt_emp.Rows[i][11].ToString());             //allow_amt3
            exSheet.Cells[pos + i, 14].Value = Double.Parse(dt_emp.Rows[i][12].ToString());             //allow_amt4
            exSheet.Cells[pos + i, 15].Value = Double.Parse(dt_emp.Rows[i][13].ToString());             //allow_amt5
            exSheet.Cells[pos + i, 16].Value = Double.Parse(dt_emp.Rows[i][14].ToString());             //allow_amt6
            exSheet.Cells[pos + i, 17].Value = Double.Parse(dt_emp.Rows[i][15].ToString());             //allow_amt7
            exSheet.Cells[pos + i, 18].Value = Double.Parse(dt_emp.Rows[i][16].ToString());             //allow_amt8
            exSheet.Cells[pos + i, 19].Value = Double.Parse(dt_emp.Rows[i][17].ToString());             //wd level 1
            exSheet.Cells[pos + i, 20].Value = Double.Parse(dt_emp.Rows[i][18].ToString());             //wd level 2
            exSheet.Cells[pos + i, 21].Value = Double.Parse(dt_emp.Rows[i][19].ToString());             //ale level 1
            exSheet.Cells[pos + i, 22].Value = Double.Parse(dt_emp.Rows[i][20].ToString());             //ale level 2
            exSheet.Cells[pos + i, 23].Value = Double.Parse(dt_emp.Rows[i][21].ToString());             //abs other level 1
            exSheet.Cells[pos + i, 24].Value = Double.Parse(dt_emp.Rows[i][22].ToString());             //abs other level 2
            exSheet.Cells[pos + i, 25].Value = Double.Parse(dt_emp.Rows[i][23].ToString());             //sal working day
            exSheet.Cells[pos + i, 26].Value = Double.Parse(dt_emp.Rows[i][24].ToString());             //ot pro
            exSheet.Cells[pos + i, 27].Value = Double.Parse(dt_emp.Rows[i][25].ToString());             //ot off
            exSheet.Cells[pos + i, 28].Value = Double.Parse(dt_emp.Rows[i][26].ToString());             //ht pro
            exSheet.Cells[pos + i, 29].Value = Double.Parse(dt_emp.Rows[i][27].ToString());             //ht off
            exSheet.Cells[pos + i, 30].Value = Double.Parse(dt_emp.Rows[i][28].ToString());             //nt30 pro
            exSheet.Cells[pos + i, 31].Value = Double.Parse(dt_emp.Rows[i][29].ToString());             //nt30 off
            exSheet.Cells[pos + i, 32].Value = Double.Parse(dt_emp.Rows[i][30].ToString());             //nt45 pro
            exSheet.Cells[pos + i, 32].Value = Double.Parse(dt_emp.Rows[i][31].ToString());             //nt45 off
            exSheet.Cells[pos + i, 34].Value = Double.Parse(dt_emp.Rows[i][32].ToString());             //nt60 pro
            exSheet.Cells[pos + i, 35].Value = Double.Parse(dt_emp.Rows[i][33].ToString());             //nt60 off
            exSheet.Cells[pos + i, 36].Value = Double.Parse(dt_emp.Rows[i][34].ToString());             //nt90 pro
            exSheet.Cells[pos + i, 37].Value = Double.Parse(dt_emp.Rows[i][35].ToString());             //nt90 off
            exSheet.Cells[pos + i, 38].Value = Double.Parse(dt_emp.Rows[i][36].ToString());             //ot sal
            exSheet.Cells[pos + i, 39].Value = Double.Parse(dt_emp.Rows[i][37].ToString());             //ot 100
            exSheet.Cells[pos + i, 40].Value = Double.Parse(dt_emp.Rows[i][38].ToString());             //allow k1 amt
            exSheet.Cells[pos + i, 41].Value = Double.Parse(dt_emp.Rows[i][39].ToString());             //allow k2 amt
            exSheet.Cells[pos + i, 42].Value = Double.Parse(dt_emp.Rows[i][40].ToString());             //allow k3 amt
            exSheet.Cells[pos + i, 43].Value = Double.Parse(dt_emp.Rows[i][41].ToString());             //allow k4 amt
            exSheet.Cells[pos + i, 44].Value = Double.Parse(dt_emp.Rows[i][42].ToString());             //allow k5 amt
            exSheet.Cells[pos + i, 45].Value = Double.Parse(dt_emp.Rows[i][43].ToString());             //allow k6 amt
            exSheet.Cells[pos + i, 46].Value = Double.Parse(dt_emp.Rows[i][44].ToString());             //allow k7 amt
            exSheet.Cells[pos + i, 47].Value = Double.Parse(dt_emp.Rows[i][45].ToString());             //allow k8 amt
            exSheet.Cells[pos + i, 48].Value = Double.Parse(dt_emp.Rows[i][46].ToString());             //return other
            exSheet.Cells[pos + i, 49].Value = Double.Parse(dt_emp.Rows[i][47].ToString());             //incentive
            exSheet.Cells[pos + i, 50].Value = Double.Parse(dt_emp.Rows[i][48].ToString());             //ale stop remain
            exSheet.Cells[pos + i, 51].Value = Double.Parse(dt_emp.Rows[i][49].ToString());             //ale stop amt
            exSheet.Cells[pos + i, 52].Value = Double.Parse(dt_emp.Rows[i][50].ToString());             //severance
            exSheet.Cells[pos + i, 53].Value = Double.Parse(dt_emp.Rows[i][51].ToString());             //severance amt
            exSheet.Cells[pos + i, 54].Value = Double.Parse(dt_emp.Rows[i][52].ToString());             //gross amt
            exSheet.Cells[pos + i, 55].Value = Double.Parse(dt_emp.Rows[i][53].ToString());             //break contract
            exSheet.Cells[pos + i, 56].Value = Double.Parse(dt_emp.Rows[i][54].ToString());             //advance other
            exSheet.Cells[pos + i, 57].Value = Double.Parse(dt_emp.Rows[i][55].ToString());             //deduct pit
            exSheet.Cells[pos + i, 58].Value = Double.Parse(dt_emp.Rows[i][56].ToString());             //income amt
            exSheet.Cells[pos + i, 59].Value = Double.Parse(dt_emp.Rows[i][57].ToString());             //income before tax
            exSheet.Cells[pos + i, 60].Value = Double.Parse(dt_emp.Rows[i][58].ToString());             //income tax
            exSheet.Cells[pos + i, 61].Value = Double.Parse(dt_emp.Rows[i][59].ToString());             //union amt
            exSheet.Cells[pos + i, 62].Value = Double.Parse(dt_emp.Rows[i][60].ToString());             //social amt
            exSheet.Cells[pos + i, 63].Value = Double.Parse(dt_emp.Rows[i][61].ToString());             //health amt
            exSheet.Cells[pos + i, 64].Value = Double.Parse(dt_emp.Rows[i][62].ToString());             //unemp amt
            exSheet.Cells[pos + i, 65].Value = Double.Parse(dt_emp.Rows[i][63].ToString());             //return no pit
            exSheet.Cells[pos + i, 66].Value = Double.Parse(dt_emp.Rows[i][64].ToString());             //advance no pit
            exSheet.Cells[pos + i, 67].Value = Double.Parse(dt_emp.Rows[i][65].ToString());             //net amt
            
            if (i != dt_emp.Rows.Count - 1 && (dt_emp.Rows[i][0].ToString() != dt_emp.Rows[i + 1][0].ToString()))
            {
                exSheet.Cells[pos + i + 1, 1, pos + i + 1, 4].Merge();
                exSheet.Cells[pos + i + 1, 1].Value= "Total " + dt_emp.Rows[i][1].ToString() + " (" + emp_dept + " employees)" ;
                exSheet.Cells[pos + i + 1, 1, pos + i + 1, 68].Rows.Font.Bold = true;
                for (k = 0; k < 59; k++)
                {
                    exSheet.Cells[pos + i + 1, 9 + k].Value = sub_total[k];
                    sub_total[k] = 0;
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
                exSheet.Cells[pos + i + 1, 1, pos + i + 1, 68].Rows.Font.Bold = true;
                exSheet.Cells[pos + i + 2, 1, pos + i + 2, 4].Merge();
                exSheet.Cells[pos + i + 2, 1].Value = "Grant Total: " + dt_emp.Rows.Count + " employee(s)";
                exSheet.Cells[pos + i + 2, 1, pos + i + 2, 68].Rows.Font.Bold = true;
                for (k = 0; k < 59; k++)
                {
                    exSheet.Cells[pos + i + 1, 9 + k].Value = sub_total[k];
                    exSheet.Cells[pos + i + 2, 9 + k].Value = grant_total[k];
                }
            }
             
        }
        //Hide allowance column
        for (i_allow = 0; i_allow < 8; i_allow++)
        {
            if (dt_allow.Rows[0][i_allow + 8].ToString() != "1")
                exSheet.Range[1, allow + i_allow].Columns.Hidden = true;

            if (dt_allow_k.Rows[0][i_allow].ToString() == "")
                exSheet.Range[1, allow_k + i_allow].Columns.Hidden = true;
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