﻿using System;
using System.Data;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Drawing;
using NativeExcel;

public partial class rpt_salary_signature_bank : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {        
        ESysLib.SetUser(Session["APP_DBUSER"].ToString());

        string p_dept, p_group, p_status, p_type, p_pay_type, p_emp_id, p_work_mon, p_times, p_emp_type, p_from_leftdate, p_to_leftdate, p_m_type;
       
		p_dept       = Request["l_dept"].ToString();
		p_group      = Request["l_group"].ToString();
		p_status     = Request["l_status"].ToString();
		p_type       = Request["l_type"].ToString();
		p_pay_type   = Request["l_pay_type"].ToString();
		p_emp_id     = Request["l_emp_id"].ToString();
		p_work_mon   = Request["l_work_mon"].ToString();
		p_times 	 = Request["l_Times_r"].ToString();
		p_emp_type 	 = Request["l_Emp_Type"].ToString();
		p_m_type 	 = Request["l_m_type"].ToString();
		
		DateTime p_month_dt=new DateTime(int.Parse(p_work_mon.Substring(0,4).ToString()),int.Parse(p_work_mon.Substring(4,2).ToString()),1) ;

        string TemplateFile = "rpt_salary_signature_bank.xls";
        string TempFile = "../../../system/temp/rpt_salary_signature_bank_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

         //Create a new workbook
		IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

		//Add worksheet
		IWorksheet exSheet = exBook.Worksheets[1];
		IRange range;
		DataTable myDT;
		
		/*
		myDT = new DataTable();
		SQL = "SELECT TO_CHAR(SYSDATE,'dd/mm/yyyy') FROM DUAL";
		myDT = ESysLib.TableReadOpen(SQL);
		exSheet.Cells["A2"].Value = string.Format("(SALARY CYCLE: TO 26/07/2012 25/08/2012)", myDT.Rows[0][0].ToString());
		*/
		
		myDT = new DataTable();
		string SQL = "select  " + 
        "d.PARTNER_NAME a0" +
        ",to_char(to_date(a.from_dt,'yyyymmdd'),'dd/mm/yyyy') a1" +
	    ",to_char(to_date(a.to_dt,'yyyymmdd'),'dd/mm/yyyy') a2" +
	    ",a.dept_nm a3" +
        ",count(a.pk) a4" +
        ",sum(nvl(a.NET_AMT,0)) a5 " +
        " from thr_month_salary a,thr_employee b,tco_org c,tco_company d  " +
        "where a.del_if=0 and b.del_if=0 and c.del_if=0 and d.del_if=0 and a.tco_dept_pk=c.pk and c.tco_company_pk=d.pk  " +
        "and a.thr_emp_pk=b.pk  " +
        "and a.work_mon='" + p_work_mon + "' " +
        " and (a.tco_dept_pk in ( " +
        "                              SELECT     g.pk " +
        "                                    FROM tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_dept + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_dept + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_dept + "' = 'ALL') " +
        " and decode('" + p_group + "','ALL','ALL',a.thr_group_pk)='" + p_group + "'" +
        " and a.emp_id like '%" + p_emp_id + "%' " +
        " and decode('" + p_status + "','ALL','ALL',a.status)='" + p_status + "'" +
        " and decode('" + p_pay_type + "','ALL','ALL',a.pay_type)='" + p_pay_type + "'" +
        " and decode('" + p_emp_type + "','ALL','ALL',a.Employee_Type)='" + p_emp_type + "'" +
        " and decode('" + p_m_type + "','ALL','ALL',a.MONEY_KIND)='" + p_m_type + "'" +
        " and decode('" + p_times + "','ALL','ALL',a.times)='" + p_times + "'" +
        " and nvl(a.net_amt,0) " + p_type +
        " group by d.PARTNER_NAME,a.from_dt,a.to_dt,a.tco_dept_pk,a.dept_nm " +
        " ORDER BY A.DEPT_NM " ;

        //Response.Write(SQL);
        //Response.End();

		DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
		int irow_emp,icol_emp;
		irow_emp = dt_Emp.Rows.Count;
		icol_emp=dt_Emp.Columns.Count;
		if (irow_emp == 0)
		{
			Response.Write("There is no data of salary");
			Response.End();
		}
		
		int s_row = 7, col = 2;		
		double tt_1 = 0, tt_2 = 0;
        string spay_type_nm = "";
        if (p_pay_type == "01")
            spay_type_nm = " - BY CASH";
        else if (p_pay_type == "02")
            spay_type_nm = " - BY BANK";
        exSheet.Range["A1:F1"].Value = string.Format("GENERAL SALARY IN {0} ( {1} ){2}", p_month_dt.ToString("MMMM yyyy").ToUpper(), dt_Emp.Rows[0]["a0"].ToString(), spay_type_nm);
		exSheet.Range["A2:F2"].Value = string.Format("(SALARY CYCLE: TO {0} {1}", dt_Emp.Rows[0]["a1"].ToString(), dt_Emp.Rows[0]["a2"].ToString());
		exSheet.Range["B4:D4"].Value = string.Format("Payment date: {0}", "02" + "-" + p_month_dt.AddMonths(1).ToString("MMM-yyyy").ToUpper());
		
		for (int i = 0; i < dt_Emp.Rows.Count; i++)
		{
			col = 2;
			exSheet.Cells["A" + s_row].Value = i + 1;
			
			exSheet.Cells["B" + s_row].Value = dt_Emp.Rows[i]["a3"].ToString();
			
			tt_1 += double.Parse(dt_Emp.Rows[i]["a4"].ToString());
			tt_2 += double.Parse(dt_Emp.Rows[i]["a5"].ToString());
			
			exSheet.Cells["C" + s_row].Value = double.Parse(dt_Emp.Rows[i]["a4"].ToString());
			exSheet.Cells["D" + s_row].Value = double.Parse(dt_Emp.Rows[i]["a5"].ToString());
			
			s_row++;
			if (i < dt_Emp.Rows.Count - 1)
			{
				exSheet.Range["A" + s_row].Rows.EntireRow.Insert();
			}
		}		
		
		exSheet.Cells["C" + s_row].Value = tt_1;
		exSheet.Cells["D" + s_row].Value = tt_2;
		s_row++;
		exSheet.Cells["D" + s_row].Value = tt_2/20000;
		
		exBook.SaveAs(TempFile);
        //ESysLib.ExcelToPdf(TempFile);
        string pdfFilePath = TempFile.Replace(".xls", ".pdf");
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