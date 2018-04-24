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

public partial class rpt_salary_summary_tab1 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {        
        ESysLib.SetUser(Session["APP_DBUSER"].ToString());

        string p_dept, p_group, p_status, pos, lsttmp, txttmp, p_work_mon, fromjoin, tojoin, lstmoney, contract;
        string lstmon_year, from_mon_year, to_mon_year, lstSal, fromsal, tosal, P_CHANGE;
        // dept=ALL&code=ALL&pos=ALL&lsttmp=2
        // &txttmp=undefined&p_work_mon=2008&contract=ALL&status=A&fromjoin=&tojoin=&lstmoney=ALL
        // lstmon_year = MON & from_mon_year = &to_mon_year = &lstTmp = A0 & fromsal = &tosal =
        p_dept = Request["org"].ToString();
        p_group = Request["wg"].ToString();
        p_status = Request["status"].ToString();
        pos = Request["pos"].ToString();
        lsttmp = Request["lsttmp"].ToString();
        txttmp = Request["txttmp"].ToString();
        p_work_mon = Request["dtyear"].ToString();
        fromjoin = Request["fromjoin"].ToString();
        tojoin = Request["tojoin"].ToString();
        lstmoney = Request["lstmoney"].ToString();
        contract = Request["contract"].ToString();
        lstmon_year = Request["lstmon_year"].ToString();
        from_mon_year = Request["from_mon_year"].ToString();
        to_mon_year = Request["to_mon_year"].ToString();
        lstSal = Request["lstSal"].ToString();
        fromsal = Request["fromsal"].ToString();
        tosal = Request["tosal"].ToString();
        P_CHANGE = Request["p_change_type"].ToString();

        string TemplateFile = "rpt_salary_summary_tab1.xls";
        string TempFile = "../../../system/temp/rpt_salary_summary_tab1_" + Session["User_ID"].ToString() + ".xls";
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


        string p_SQL = "";

        if (P_CHANGE == "ALL")
        {
            p_SQL = "";
        }
        else if (P_CHANGE == "01")
        {

            p_SQL = "  AND ((A.ORG_DT IS NOT NULL AND hr_f_period_month_2(A.ORG_DT,A.SAL_PERIOD) = '" + p_work_mon + "')  " +
              "                                                OR (A.POSITION_DT IS NOT NULL AND hr_f_period_month_2(A.POSITION_DT,A.SAL_PERIOD) = '" + p_work_mon + "') " +
              "                                                OR ( A.CONFIRM_DT IS NOT NULL AND hr_f_period_month_2(A.CONFIRM_DT,A.SAL_PERIOD) = '" + p_work_mon + "' )) ";
        }
        else if (P_CHANGE == "02")
        {

            p_SQL = "  AND A.ORG_DT IS NOT NULL AND hr_f_period_month_2(A.ORG_DT,A.SAL_PERIOD) = '" + p_work_mon + "'  ";
        }
        else if (P_CHANGE == "03")
        {

            p_SQL = "  AND A.POSITION_DT IS NOT NULL AND hr_f_period_month_2(A.POSITION_DT,A.SAL_PERIOD) = '" + p_work_mon + "'  ";
        }
        else if (P_CHANGE == "04")
        {

            p_SQL = "  AND A.CONFIRM_DT IS NOT NULL AND hr_f_period_month_2(A.CONFIRM_DT,A.SAL_PERIOD) = '" + p_work_mon + "'  ";
        }


		
		myDT = new DataTable();

        string SQL
    = "SELECT   b.org_nm, c.workgroup_nm, a.emp_id, a.full_name " +
        "               ,TO_CHAR (TO_DATE (a.join_dt, 'yyyymmdd'), 'dd/mm/yyyy'),d.code_nm, " +
        "                b.org_nm,TO_CHAR (TO_DATE (a.org_dt, 'yyyymmdd'), 'dd/mm/yyyy'),p.code_nm,TO_CHAR (TO_DATE (a.position_dt, 'yyyymmdd'), 'dd/mm/yyyy'),nvl(a.BASIC_SAL,0) " +
        "                ,TO_CHAR (TO_DATE (a.CONFIRM_DT, 'yyyymmdd'), 'dd/mm/yyyy'),a.remark_sal,nvl(a.allow_amt1,0) " +
        "                ,e.org_nm,TO_CHAR (TO_DATE (e.org_dt, 'yyyymmdd'), 'dd/mm/yyyy'),e.POS_NM,TO_CHAR (TO_DATE (e.position_dt, 'yyyymmdd'), 'dd/mm/yyyy'),nvl(e.salary_level2,0) " +
        "                ,TO_CHAR (TO_DATE (e.CONFIRM_DT, 'yyyymmdd'), 'dd/mm/yyyy'),e.remark_sal,nvl(e.allow_amt1,0) " +
        "          FROM thr_employee a,tco_org b,thr_work_group c, " +
        "               (SELECT code, code_nm FROM vhr_hr_code WHERE ID = 'HR0001') d, " +
        "                  (SELECT code, code_nm FROM vhr_hr_code WHERE ID = 'HR0008') p,thr_salary_manage e " +
        "         WHERE a.del_if = 0 " +
        "           AND b.del_if = 0 " +
        "           AND c.del_if = 0 " +
        "           AND e.del_if(+) = 0 " +
        "           AND a.thr_wg_pk = c.pk " +
        "           AND a.tco_org_pk = b.pk " +
        "           AND e.thr_emp_pk(+) = a.pk " +
        "           AND a.contract_type = d.code(+) " +
        "           and a.pos_type=p.code(+) " +
        "           and e.work_mon(+)='" + p_work_mon + "' " +
        "          AND DECODE ('" + p_group + "', 'ALL', '" + p_group + "', a.thr_wg_pk) = " +
        "                                                                '" + p_group + "' " +
        "           AND (   a.tco_org_pk IN ( " +
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
        "           AND DECODE ('" + pos + "', 'ALL', '" + pos + "', a.pos_type) = '" + pos + "' " +
        "           AND DECODE ('" + p_status + "', 'ALL', '" + p_status + "', a.status) = '" + p_status + "' " +
        "  AND DECODE ('" + contract + "','ALL','" + contract + "',a.contract_type) = '" + contract + "'" +
        "  AND UPPER (DECODE ('" + lsttmp + "',1, a.full_name,2, a.emp_id,a.id_num)) LIKE '%' || UPPER ('" + txttmp + "') || '%' " +
        "           AND (   '" + fromjoin + "' IS NULL " +
        "                OR '" + tojoin + "' IS NULL " +
        "                OR a.join_dt BETWEEN '" + fromjoin + "' AND '" + tojoin + "' " +
        "               ) " +
        "           AND (   (    (   MONTHS_BETWEEN (SYSDATE, " +
        "                                            TO_DATE (a.join_dt, 'yyyymmdd') " +
        "                                           ) BETWEEN '" + from_mon_year + "' " +
        "                                                 AND '" + to_mon_year + "'" +
        "                         OR '" + from_mon_year + "' IS NULL " +
        "                         OR '" + to_mon_year + "' IS NULL " +
        "                        ) " +
        "                    AND '" + lstmon_year + "' = 'MON' " +
        "                   ) " +
        "                OR (    (     MONTHS_BETWEEN (SYSDATE, " +
        "                                              TO_DATE (a.join_dt, 'yyyymmdd') " +
        "                                             ) " +
        "                            / 12 BETWEEN '" + from_mon_year + "' AND '" + to_mon_year + "' " +
        "                         OR '" + from_mon_year + "' IS NULL " +
        "                         OR '" + to_mon_year + "' IS NULL " +
        "                        ) " +
        "                    AND '" + lstmon_year + "' = 'YEAR' " +
        "                   ) " +
        "               ) " +
        " AND ( DECODE('" + lstSal + "','A',E.SALARY_LEVEL1,'A0',E.SALARY_LEVEL2,'A1',E.ALLOW_AMT1,'A2',E.ALLOW_AMT2,'A3',E.ALLOW_AMT3,'A4',E.ALLOW_AMT4,'A5',E.ALLOW_AMT5 " +
        "  ,'A6',E.ALLOW_AMT6,'A7',E.ALLOW_AMT7,'A8',E.ALLOW_AMT8) BETWEEN '" + fromsal + "' AND '" + tosal + "' " +
        "                OR '" + fromsal + "' IS NULL " +
        "                OR '" + tosal + "' IS NULL " +
        "               ) " +
        "      AND DECODE('" + lstmoney + "','ALL','" + lstmoney + "',A.MONEY_KIND)='" + lstmoney + "'  ";
        SQL += p_SQL;
        SQL += "      ORDER BY NVL(B.SEQ,0),B.org_nm, C.workgroup_id, A.emp_id ";
        
					
			//Response.Write(SQL);
			//Response.End();
		myDT = ESysLib.TableReadOpen(SQL);
		
			
		if (myDT.Rows.Count == 0)
		{
			Response.Write("There is no data of salary");
			Response.End();
		}


        string para = "'" + p_dept + "','" + p_work_mon + "'";
        DataTable dt_com = ESysLib.TableReadOpenCursor("HR_SP_RPT_COMPANY", para);


        int l_row = myDT.Rows.Count;
        int l_col = myDT.Columns.Count;

        double[] grant_total = new double[l_col+1];

        int l_pos = 7;

        for (int k = 0; k < l_col+1; k++)
        {
            grant_total[k] = 0;
        }

        exSheet.Cells["A1"].Value = string.Format("INFORMATION CHANGE IN {0}", dt_com.Rows[0]["c5"].ToString());
        exSheet.Cells["A2"].Value = string.Format("THÔNG TIN LƯƠNG TRONG THÁNG {0}", dt_com.Rows[0]["c5"].ToString());

        for (int i = 0; i < l_row - 1; i++)
        {

            exSheet.Range[l_pos + i + 1, l_col].Rows.EntireRow.Insert();//insert dong moi 
        }

        for (int i = 0; i < l_row; i++)
        {

            exSheet.Cells[l_pos + i, 1].Value = i + 1;
            for (int j = 1; j < l_col+1; j++) 
            {

                if (j == 11 || j == 14 || j == 19 || j == 22)
                {

                    grant_total[j] = grant_total[j] + double.Parse(myDT.Rows[i][j - 1].ToString());

                    exSheet.Cells[l_pos + i, j + 1].Value = double.Parse(myDT.Rows[i][j - 1].ToString());
                }
                else
                    exSheet.Cells[l_pos + i, j + 1].Value = myDT.Rows[i][j - 1].ToString();

            }
         }

		
		//total
        exSheet.Cells[l_pos + l_row, 1].Value = "Total - " + l_row+" Employees";

        for (int j = 1; j < l_col+1; j++)
        {

            if (j == 11 || j == 14 || j == 19 || j == 22)
            {

                exSheet.Cells[l_pos + l_row, j + 1].Value = grant_total[j];
            }
            

        }
        
		
		//exSheet.Cells["F" + (row)].Value = total;
		
		
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
