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

public partial class rpt_working_summary : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {        
        ESysLib.SetUser(Session["APP_DBUSER"].ToString());

        string TemplateFile = "rpt_working_summary.xls";
        string TempFile = "../../../system/temp/rpt_working_summary_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

         //Create a new workbook
		IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

		//Add worksheet
		IWorksheet exSheet = exBook.Worksheets[1];
		IRange range;		
		MemoryStream stream;
		Bitmap b;

        string p_tco_dept_pk, p_thr_group_pk, p_status, p_emp_id, p_work_mon, p_from_dt, p_to_dt, p_dept_nm, p_salary_period, p_nation, p_lstEmpID;
    
		p_tco_dept_pk = Request["l_tco_dept_pk"].ToString();
		p_thr_group_pk = Request["l_thr_group_pk"].ToString();
		p_status = Request["l_status"].ToString();
		p_emp_id = Request["l_emp_id"].ToString();
		p_work_mon = Request["l_work_mon"].ToString();
		p_to_dt = Request["l_to_dt"].ToString();
		p_from_dt = Request["l_from_dt"].ToString();
		p_dept_nm = Request["l_dept_nm"].ToString();
		p_salary_period = Request["l_SalaryPeriod"].ToString();
		p_nation = Request["l_nation"].ToString();
        p_lstEmpID = Request["l_lstEmpID"].ToString();
		
		//-----------------information of company-----------------
	string SQL_Com
		= "select  a.PARTNER_LNAME,a.ADDR1,a.PHONE_NO,b.data,to_char(to_date('"+ p_work_mon +"','yyyymm'),'MON-YYYY') " +
			"from tco_company a, tco_bpphoto b " +
			"where a.DEL_IF=0  and b.del_if(+) = 0 and a.TCO_BPPHOTO_PK = b.pk(+)" +
			"and a.pk in ( select tco_company_pk from  " +
			"               tco_org  f " +
			"               where  f.pk IN ( " +
			"                              SELECT     g.pk " +
			"                                    FROM tco_org g " +
			"                                   WHERE g.del_if = 0 " +
			"                              START WITH g.pk = " +
			"                                            DECODE ('" + p_tco_dept_pk + "', " +
			"                                                    'ALL', 0, " +
			"                                                    '" + p_tco_dept_pk + "' " +
			"                                                   ) " +
			"                              CONNECT BY PRIOR g.pk = g.p_pk) " +
			"                        OR '" + p_tco_dept_pk + "' = 'ALL') " +
			"and rownum=1 " ;

		DataTable dt_Com = ESysLib.TableReadOpen(SQL_Com);

		exSheet.Range["C1"].Value = dt_Com.Rows[0][0].ToString();
		exSheet.Range["C2"].Value = dt_Com.Rows[0][1].ToString();
		exSheet.Range["C3"].Value = dt_Com.Rows[0][2].ToString();

		if (!string.IsNullOrEmpty(dt_Com.Rows[0][3].ToString()))
		{
			byte[] MyData = new byte[0];
			MyData = (byte[])dt_Com.Rows[0][3];
			stream = new MemoryStream(MyData);

			b = new Bitmap(stream);
			exSheet.Cells["B1"].Select();
			exSheet.Shapes.AddPicture(ESysLib.ResizeImage(b, 75, 40));
		}
 
	
		//-----------------information of employee-----------------
		string SQL = "  SELECT a.dept_NM, " + 
		"         a.EMP_ID, " +
		"         a.full_name, " +
		"         TO_CHAR (TO_DATE (a.JOIN_DT, 'yyyymmdd'), 'dd/mm/yyyy') join_dt, " +
		"         a.D1, a.D2, a.D3, a.D4, a.D5, a.D6, a.D7, a.D8, a.D9, a.D10, " +
		"         a.D11, a.D12, a.D13, a.D14, a.D15, a.D16, a.D17, a.D18, a.D19, a.D20, " +
		"         a.D21, a.D22, a.D23, a.D24, a.D25, a.D26, a.D27, a.D28, a.D29, a.D30, a.D31, " +
		"        DECODE (b.D1, 0, '', b.D1) || DECODE (NVL (b.N1, 0), 0, '', ' N' || b.N1) N1, " +
		"        DECODE (b.D2, 0, '', b.D2) || DECODE (NVL (b.N2, 0), 0, '', ' N' || b.N2) N2, " +
		"        DECODE (b.D3, 0, '', b.D3) || DECODE (NVL (b.N3, 0), 0, '', ' N' || b.N3) N3, " +
		"        DECODE (b.D4, 0, '', b.D4) || DECODE (NVL (b.N4, 0), 0, '', ' N' || b.N4) N4, " +
		"        DECODE (b.D5, 0, '', b.D5) || DECODE (NVL (b.N5, 0), 0, '', ' N' || b.N5) N5, " +
		"        DECODE (b.D6, 0, '', b.D6) || DECODE (NVL (b.N6, 0), 0, '', ' N' || b.N6) N6, " +
		"        DECODE (b.D7, 0, '', b.D7) || DECODE (NVL (b.N7, 0), 0, '', ' N' || b.N7) N7, " +
		"        DECODE (b.D8, 0, '', b.D8) || DECODE (NVL (b.N8, 0), 0, '', ' N' || b.N8) N8, " +
		"        DECODE (b.D9, 0, '', b.D9) || DECODE (NVL (b.N9, 0), 0, '', ' N' || b.N9) N9, " +
		"        DECODE (b.D10, 0, '', b.D10) || DECODE (NVL (b.N10, 0), 0, '', ' N' || b.N10) N10, " +
		"        DECODE (b.D11, 0, '', b.D11) || DECODE (NVL (b.N11, 0), 0, '', ' N' || b.N11) N11, " +
		"        DECODE (b.D12, 0, '', b.D12) || DECODE (NVL (b.N12, 0), 0, '', ' N' || b.N12) N12, " +
		"        DECODE (b.D13, 0, '', b.D13) || DECODE (NVL (b.N13, 0), 0, '', ' N' || b.N13) N13, " +
		"        DECODE (b.D14, 0, '', b.D14) || DECODE (NVL (b.N14, 0), 0, '', ' N' || b.N14) N14, " +
		"        DECODE (b.D15, 0, '', b.D15) || DECODE (NVL (b.N15, 0), 0, '', ' N' || b.N15) N15, " +
		"        DECODE (b.D16, 0, '', b.D16) || DECODE (NVL (b.N16, 0), 0, '', ' N' || b.N16) N16, " +
		"        DECODE (b.D17, 0, '', b.D17) || DECODE (NVL (b.N17, 0), 0, '', ' N' || b.N17) N17, " +
		"        DECODE (b.D18, 0, '', b.D18) || DECODE (NVL (b.N18, 0), 0, '', ' N' || b.N18) N18, " +
		"        DECODE (b.D19, 0, '', b.D19) || DECODE (NVL (b.N19, 0), 0, '', ' N' || b.N19) N19, " +
		"        DECODE (b.D20, 0, '', b.D20) || DECODE (NVL (b.N20, 0), 0, '', ' N' || b.N20) N20, " +
		"        DECODE (b.D21, 0, '', b.D21) || DECODE (NVL (b.N21, 0), 0, '', ' N' || b.N21) N21, " +
		"        DECODE (b.D22, 0, '', b.D22) || DECODE (NVL (b.N22, 0), 0, '', ' N' || b.N22) N22, " +
		"        DECODE (b.D23, 0, '', b.D23) || DECODE (NVL (b.N23, 0), 0, '', ' N' || b.N23) N23, " +
		"        DECODE (b.D24, 0, '', b.D24) || DECODE (NVL (b.N24, 0), 0, '', ' N' || b.N24) N24, " +
		"        DECODE (b.D25, 0, '', b.D25) || DECODE (NVL (b.N25, 0), 0, '', ' N' || b.N25) N25, " +
		"        DECODE (b.D26, 0, '', b.D26) || DECODE (NVL (b.N26, 0), 0, '', ' N' || b.N26) N26, " +
		"        DECODE (b.D27, 0, '', b.D27) || DECODE (NVL (b.N27, 0), 0, '', ' N' || b.N27) N27, " +
		"        DECODE (b.D28, 0, '', b.D28) || DECODE (NVL (b.N28, 0), 0, '', ' N' || b.N28) N28, " +
		"        DECODE (b.D29, 0, '', b.D29) || DECODE (NVL (b.N29, 0), 0, '', ' N' || b.N29) N29, " +
		"        DECODE (b.D30, 0, '', b.D30) || DECODE (NVL (b.N30, 0), 0, '', ' N' || b.N30) N30, " +
		"        DECODE (b.D31, 0, '', b.D31) || DECODE (NVL (b.N31, 0), 0, '', ' N' || b.N31) N31, " +
		"         ROUND (NVL (a.TOTAL_WD, 0), 2) TOTAL_WD, " +
		"         b.TOTAL_OT, " +
		"         b.TOTAL_NT, " +
		"         b.TOTAL_HT, " +
		"         a.ale_have, " +
		"         a.total_ale_use, " +
		"         a.remain_ale, " +
		"         a.abs_ale " +
		"    FROM thr_work_mon a, " +
		"         thr_extra_month b, " +
		"         thr_work_group c, " +
		"         thr_employee e " +
        "where a.del_if=0 and b.del_if=0 and c.del_if=0 and e.del_if=0 and c.pk=a.thr_group_pk " +
        "and a.thr_emp_pk=b.thr_emp_pk  and e.pk=a.thr_emp_pk " +
        "and a.work_mon = b.work_mon " +
        "and a.work_mon='" + p_work_mon + "' " +
        "and b.work_mon='" + p_work_mon + "' " +
        "and (a.tco_dept_pk in ( " +
        "                              SELECT     g.pk " +
        "                                    FROM tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_tco_dept_pk + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_tco_dept_pk + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_tco_dept_pk + "' = 'ALL') " +
        "and decode('" + p_thr_group_pk + "','ALL','ALL',a.thr_group_pk)='" + p_thr_group_pk + "' " +
        "and ((a.emp_id like '%" + p_emp_id + "%' )" +        
        "and decode('" + p_status + "','ALL','ALL',a.status)='" + p_status + "' " +
        " and decode('" + p_salary_period + "','ALL','ALL',nvl(a.sal_period,' '))='" + p_salary_period + "' " +
        " and decode('" + p_nation + "','ALL','ALL',nvl(e.nation,'01'))='" + p_nation + "' " +
        "order by a.dept_nm,a.emp_id " ;

       
				
		//Response.Write(SQL);
		//Response.End();
		DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
		
		string SQL_Cal = "select substr(t.car_date,-2),t.hol_type " +
        "from thr_calendar T,thr_close m " +
        "where t.del_if=0 and m.del_if=0 and m.id='" + p_salary_period + "' and m.month_close='" + p_work_mon + "' and m.tco_company_pk=t.tco_company_pk " +
        "   and m.tco_company_pk=(select tco_company_pk from tco_org g where g.del_if=0 and g.pk='" + p_tco_dept_pk + "' ) " +
        "    and t.car_date between m.from_dt and '" + p_to_dt + "' order by t.car_date ";
		
		//Response.Write(SQL_Cal);
		//Response.End();
		DataTable dt_Cal = ESysLib.TableReadOpen(SQL_Cal);
		
		int row_emp = dt_Emp.Rows.Count;
		int row_cal = dt_Cal.Rows.Count;

		int s_col = 7;
		int s_row = 6;
		int tt_col = row_cal + 15;
		
		if (row_emp <= 0)
		{
			Response.Write("There is no data !!!");
			Response.End();
		}
		
		//header columns
		for (int row = 0; row < row_cal; row++)
		{
			exSheet.Range[4, s_col + row, 5, s_col + row].Value = double.Parse(dt_Cal.Rows[row][0].ToString());
		}
		
		s_row = 6;
		//insert new row
		for (int row = 1; row < row_emp; row++)
		{
			exSheet.Range["A8:AT9"].EntireRow.Insert();
		}

		if (row_emp > 1)
			exSheet.Range["A6:AT7"].Rows.Copy(exSheet.Range["A" + (s_row + 2) + ":" + "AT" + (((row_emp - 1) * 2) + s_row -1 + 2)] , XlPasteType.xlPasteAll);

		for (int row = 0; row < row_emp; row++)
		{
			exSheet.Range["A" + (s_row + row) + ":A" + (s_row + row + 1)].Value = row + 1;
			exSheet.Range["B" + (s_row + row) + ":B" + (s_row + row + 1)].Value = dt_Emp.Rows[row]["DEPT_NM"].ToString();
			exSheet.Range["C" + (s_row + row) + ":C" + (s_row + row + 1)].Value = dt_Emp.Rows[row]["EMP_ID"].ToString();
			exSheet.Range["D" + (s_row + row) + ":D" + (s_row + row + 1)].Value = dt_Emp.Rows[row]["FULL_NAME"].ToString();
			exSheet.Range["E" + (s_row + row) + ":E" + (s_row + row + 1)].Value = dt_Emp.Rows[row]["JOIN_DT"].ToString();

			GeneralData(exSheet, "1", "G", s_row + row, row, "D1", dt_Emp);
			GeneralData(exSheet, "1", "G", s_row + row + 1, row, "N1", dt_Emp);
			GeneralData(exSheet, "1", "H", s_row + row, row, "D2", dt_Emp);
			GeneralData(exSheet, "1", "H", s_row + row + 1, row, "N2", dt_Emp);
			GeneralData(exSheet, "1", "I", s_row + row, row, "D3", dt_Emp);
			GeneralData(exSheet, "1", "I", s_row + row + 1, row, "N3", dt_Emp);
			GeneralData(exSheet, "1", "J", s_row + row, row, "D4", dt_Emp);
			GeneralData(exSheet, "1", "J", s_row + row + 1, row, "N4", dt_Emp);
			GeneralData(exSheet, "1", "K", s_row + row, row, "D5", dt_Emp);
			GeneralData(exSheet, "1", "K", s_row + row + 1, row, "N5", dt_Emp);
			GeneralData(exSheet, "1", "L", s_row + row, row, "D6", dt_Emp);
			GeneralData(exSheet, "1", "L", s_row + row + 1, row, "N6", dt_Emp);
			GeneralData(exSheet, "1", "M", s_row + row, row, "D7", dt_Emp);
			GeneralData(exSheet, "1", "M", s_row + row + 1, row, "N7", dt_Emp);
			GeneralData(exSheet, "1", "N", s_row + row, row, "D8", dt_Emp);
			GeneralData(exSheet, "1", "N", s_row + row + 1, row, "N8", dt_Emp);
			GeneralData(exSheet, "1", "O", s_row + row, row, "D9", dt_Emp);
			GeneralData(exSheet, "1", "O", s_row + row + 1, row, "N9", dt_Emp);
			GeneralData(exSheet, "1", "P", s_row + row, row, "D10", dt_Emp);
			GeneralData(exSheet, "1", "P", s_row + row + 1, row, "N10", dt_Emp);

			GeneralData(exSheet, "1", "Q", s_row + row, row, "D11", dt_Emp);
			GeneralData(exSheet, "1", "Q", s_row + row + 1, row, "N11", dt_Emp);
			GeneralData(exSheet, "1", "R", s_row + row, row, "D12", dt_Emp);
			GeneralData(exSheet, "1", "R", s_row + row + 1, row, "N12", dt_Emp);
			GeneralData(exSheet, "1", "S", s_row + row, row, "D13", dt_Emp);
			GeneralData(exSheet, "1", "S", s_row + row + 1, row, "N13", dt_Emp);
			GeneralData(exSheet, "1", "T", s_row + row, row, "D14", dt_Emp);
			GeneralData(exSheet, "1", "T", s_row + row + 1, row, "N14", dt_Emp);
			GeneralData(exSheet, "1", "U", s_row + row, row, "D15", dt_Emp);
			GeneralData(exSheet, "1", "U", s_row + row + 1, row, "N15", dt_Emp);
			GeneralData(exSheet, "1", "V", s_row + row, row, "D16", dt_Emp);
			GeneralData(exSheet, "1", "V", s_row + row + 1, row, "N16", dt_Emp);
			GeneralData(exSheet, "1", "W", s_row + row, row, "D17", dt_Emp);
			GeneralData(exSheet, "1", "W", s_row + row + 1, row, "N17", dt_Emp);
			GeneralData(exSheet, "1", "X", s_row + row, row, "D18", dt_Emp);
			GeneralData(exSheet, "1", "X", s_row + row + 1, row, "N18", dt_Emp);
			GeneralData(exSheet, "1", "Y", s_row + row, row, "D19", dt_Emp);
			GeneralData(exSheet, "1", "Y", s_row + row + 1, row, "N19", dt_Emp);
			GeneralData(exSheet, "1", "Z", s_row + row, row, "D20", dt_Emp);
			GeneralData(exSheet, "1", "Z", s_row + row + 1, row, "N20", dt_Emp);

			GeneralData(exSheet, "1", "AA", s_row + row, row, "D21", dt_Emp);
			GeneralData(exSheet, "1", "AA", s_row + row + 1, row, "N21", dt_Emp);
			GeneralData(exSheet, "1", "AB", s_row + row, row, "D22", dt_Emp);
			GeneralData(exSheet, "1", "AB", s_row + row + 1, row, "N22", dt_Emp);
			GeneralData(exSheet, "1", "AC", s_row + row, row, "D23", dt_Emp);
			GeneralData(exSheet, "1", "AC", s_row + row + 1, row, "N23", dt_Emp);
			GeneralData(exSheet, "1", "AD", s_row + row, row, "D24", dt_Emp);
			GeneralData(exSheet, "1", "AD", s_row + row + 1, row, "N24", dt_Emp);
			GeneralData(exSheet, "1", "AE", s_row + row, row, "D25", dt_Emp);
			GeneralData(exSheet, "1", "AE", s_row + row + 1, row, "N25", dt_Emp);
			GeneralData(exSheet, "1", "AF", s_row + row, row, "D26", dt_Emp);
			GeneralData(exSheet, "1", "AF", s_row + row + 1, row, "N26", dt_Emp);
			GeneralData(exSheet, "1", "AG", s_row + row, row, "D27", dt_Emp);
			GeneralData(exSheet, "1", "AG", s_row + row + 1, row, "N27", dt_Emp);
			GeneralData(exSheet, "1", "AH", s_row + row, row, "D28", dt_Emp);
			GeneralData(exSheet, "1", "AH", s_row + row + 1, row, "N28", dt_Emp);
			GeneralData(exSheet, "1", "AI", s_row + row, row, "D29", dt_Emp);
			GeneralData(exSheet, "1", "AI", s_row + row + 1, row, "N29", dt_Emp);
			GeneralData(exSheet, "1", "AJ", s_row + row, row, "D30", dt_Emp);
			GeneralData(exSheet, "1", "AJ", s_row + row + 1, row, "N30", dt_Emp);

			GeneralData(exSheet, "1", "AK", s_row + row, row, "D31", dt_Emp);
			GeneralData(exSheet, "1", "AK", s_row + row + 1, row, "N31", dt_Emp);

			GeneralData(exSheet, "2", "AL", s_row + row, row, "TOTAL_WD", dt_Emp);
			GeneralData(exSheet, "2", "AM", s_row + row, row, "TOTAL_OT", dt_Emp);
			GeneralData(exSheet, "2", "AN", s_row + row, row, "TOTAL_NT", dt_Emp);
			GeneralData(exSheet, "2", "AO", s_row + row, row, "TOTAL_HT", dt_Emp);
			GeneralData(exSheet, "2", "AP", s_row + row, row, "ALE_HAVE", dt_Emp);
			GeneralData(exSheet, "2", "AQ", s_row + row, row, "TOTAL_ALE_USE", dt_Emp);
			GeneralData(exSheet, "2", "AR", s_row + row, row, "REMAIN_ALE", dt_Emp);
			GeneralData(exSheet, "2", "AS", s_row + row, row, "ABS_ALE", dt_Emp);

			s_row++;
		}
		
		// draw color
		s_row = 6;
		int temp = 0;
		for (int row = 0; row < row_cal; row++)
		{
			temp = 31 - row_cal;
			switch (temp)
			{
				case 3:
					exSheet.Range["AI1"].Columns.Hidden = true;
					break;
				case 2:
					exSheet.Range["AJ1"].Columns.Hidden = true;
					break;
				case 1:
					exSheet.Range["AK1"].Columns.Hidden = true;
					break;
			}

			switch (dt_Cal.Rows[row][1].ToString())
			{
				case "SUN":
					exSheet.Range[s_row, row + s_col, ((row_emp * 2) + s_row - 1), row + s_col].Interior.Color = Color.SkyBlue;
					break;

				case "HOL":
					exSheet.Range[s_row, row + s_col, ((row_emp * 2) + s_row - 1), row + s_col].Interior.Color = Color.Pink;
					break;
			}
		}
     
     
		
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
	
	public static void GeneralData(IWorksheet exSheet, string type, string col_name, int col_num, int row_data, string col_data, DataTable myDT)
	{
		switch (type)
		{
			case "1":
				if (IsNumeric(myDT.Rows[row_data][col_data].ToString()))
					exSheet.Range[col_name + col_num + ":" + col_name + col_num].Value = double.Parse(myDT.Rows[row_data][col_data].ToString());
				else
					exSheet.Range[col_name + col_num + ":" + col_name + col_num].Value = myDT.Rows[row_data][col_data].ToString();
				break;
			case "2":
				if (IsNumeric(myDT.Rows[row_data][col_data].ToString()))
					exSheet.Range[col_name + col_num + ":" + col_name + (col_num + 1)].Value = double.Parse(myDT.Rows[row_data][col_data].ToString());
				else
					exSheet.Range[col_name + col_num + ":" + col_name + (col_num + 1)].Value = myDT.Rows[row_data][col_data].ToString();
			break;
		}
	}
	public static bool IsNumeric(string strNum)
	{
		try
		{
			double tmp = double.Parse(strNum);
			return true;
		}
		catch
		{
			return false;
		}
	}
 
	
}
