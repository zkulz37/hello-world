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

public partial class rpt_monthly_change : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {        
        ESysLib.SetUser(Session["APP_DBUSER"].ToString());

        string p_dept, p_group, p_status, pos, lsttmp, txttmp, p_work_mon, fromjoin, tojoin, lstmoney, contract,p_type, p_sql;

        
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
        p_type = Request["l_type"].ToString();

        string TemplateFile = "rpt_monthly_change.xls";
        string TempFile = "../../../system/temp/rpt_monthly_change_" + Session["User_ID"].ToString() + ".xls";
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

        
        p_sql = "";

        if (p_type == "01")//all
        {
            p_sql = "           and (NVL(CUR.ORG_NM,'')<>NVL(LAS.ORG_NM,'') " +
               "                OR NVL(CUR.POS_NM,'')<>NVL(LAS.POS_NM,'') " +
               "                OR NVL(CUR.SALARY_LEVEL2,0)<>NVL(LAS.SALARY_LEVEL2,0) " +
               "                OR NVL(CUR.ALLOW_AMT1,0)<>NVL(LAS.ALLOW_AMT1,0) " +
               "               )  ";
        }
        else if (p_type == "02")//org
        {
            p_sql = " and NVL(CUR.ORG_NM,'')<>NVL(LAS.ORG_NM,'') ";
        }
        else if (p_type == "03")//pos
        {
            p_sql = " and NVL(CUR.POS_NM,'')<>NVL(LAS.POS_NM,'') ";
        }
        else if (p_type == "04")//sal
        {
            p_sql = " and NVL(CUR.SALARY_LEVEL2,0)<>NVL(LAS.SALARY_LEVEL2,0) ";
        }


		
		myDT = new DataTable();

        string SQL
    = "      SELECT   b.org_nm co, a.emp_id c1, a.full_name c2, " +
        "               TO_CHAR (TO_DATE (a.join_dt, 'yyyymmdd'), 'dd/mm/yyyy') c3 " +
        "               ,d.code_nm c4 " +
        "               ,LAS.ORG_NM C5,LAS.ORG_DT C6,LAS.POS_NM C7,LAS.POSITION_DT C8,nvl(LAS.SALARY_LEVEL2,0) C9 " +
        "               ,TO_CHAR (TO_DATE (LAS.CONFIRM_DT, 'yyyymmdd'), 'dd/mm/yyyy') C10" +
        "  ,nvl(LAS.ALLOW_AMT1,0) C11,LAS.REMARK_SAL C12" +
        "               ,CUR.ORG_NM C13,CUR.ORG_DT C14,CUR.POS_NM C15,CUR.POSITION_DT C16,nvl(CUR.SALARY_LEVEL2,0) C17" +
        "               ,TO_CHAR (TO_DATE (CUR.CONFIRM_DT, 'yyyymmdd'), 'dd/mm/yyyy') C18 " +
        "  ,nvl(CUR.ALLOW_AMT1,0) C19,CUR.REMARK_SAL C20 " +
        "          FROM thr_employee a,tco_org b,thr_work_group c " +
        "               ,(SELECT code, code_nm FROM vhr_hr_code WHERE ID = 'HR0001') d " +
        "              , (SELECT t.thr_emp_pk,t.org_nm,to_char(to_date(t.org_dt,'yyyymmdd'),'dd/mm/yyyy') org_dt " +
        "               ,t.POS_NM,to_char(to_date(t.position_dt,'yyyymmdd'),'dd/mm/yyyy') position_dt,t.SALARY_LEVEL2,t.CONFIRM_DT,t.ALLOW_AMT1,t.remark_sal " +
        "                  FROM thr_salary_manage t " +
        "                 WHERE t.del_if = 0 " +
        "                   AND t.work_mon = '" + p_work_mon + "') CUR, " +
        "               (SELECT V.thr_emp_pk,v.org_nm,to_char(to_date(v.org_dt,'yyyymmdd'),'dd/mm/yyyy') org_dt " +
        "               ,V.POS_NM,to_char(to_date(v.position_dt,'yyyymmdd'),'dd/mm/yyyy') position_dt,V.SALARY_LEVEL2,V.CONFIRM_DT,V.ALLOW_AMT1,v.remark_sal " +
        "                  FROM thr_salary_manage V " +
        "                 WHERE V.del_if = 0 " +
        "                   AND V.work_mon = to_char(add_months(to_date('" + p_work_mon + "','yyyymm'),-1),'yyyymm')) LAS                " +
        "         WHERE a.del_if = 0 " +
        "           AND b.del_if = 0 " +
        "           AND c.del_if = 0 " +
        "           AND a.thr_wg_pk = c.pk " +
        "           AND a.tco_org_pk = b.pk " +
        "           AND a.pk=CUR.thr_emp_pk " +
        "           and a.pk=LAS.THR_EMP_PK ";
        SQL += p_sql;
        SQL +=
        "           and a.contract_type=d.code " +
        "           AND CUR.thr_emp_pk=LAS.THR_EMP_PK " +
        " AND DECODE ('" + p_group + "', 'ALL', '" + p_group + "', a.thr_wg_pk) ='" + p_group + "'" +
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
            "      AND DECODE ('" + p_status + "', 'ALL', '" + p_status + "', a.status) = '" + p_status + "' " +
            "           AND DECODE ('" + contract + "', " +
            "                       'ALL', '" + contract + "', " +
            "                       a.contract_type " +
            "                      ) = '" + contract + "' " +
            "           AND UPPER (DECODE ('" + lsttmp + "', " +
            "                              1, a.full_name, " +
            "                              2, a.emp_id, " +
            "                              a.id_num " +
            "                             ) " +
            "                     ) LIKE '%' || UPPER ('" + txttmp + "') || '%' " +
            "           AND (   '" + fromjoin + "' IS NULL " +
            "                OR '" + tojoin + "' IS NULL " +
            "                OR a.join_dt BETWEEN '" + fromjoin + "' AND '" + tojoin + "' " +
            "               ) " +
            "   AND DECODE('" + lstmoney + "','ALL','" + lstmoney + "',A.MONEY_KIND)='" + lstmoney + "'" +
              "      ORDER BY NVL(B.SEQ,0),B.org_nm, A.emp_id ";
        
					
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

        for (int i = 0; i < l_row - 1; i++)
        {

            exSheet.Range[l_pos + i + 1, l_col].Rows.EntireRow.Insert();//insert dong moi 
        }

        for (int i = 0; i < l_row; i++)
        {

            exSheet.Cells[l_pos + i, 1].Value = i + 1;
            for (int j = 1; j < l_col+1; j++) 
            {

                if (j == 10 || j == 12 || j == 18 || j == 20)
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

            if (j == 10 || j == 12 || j == 18 || j == 20)
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
