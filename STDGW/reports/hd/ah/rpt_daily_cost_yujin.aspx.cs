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

public partial class rpt_daily_cost_yujin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {        
        ESysLib.SetUser(Session["APP_DBUSER"].ToString());

        string TemplateFile = "rpt_daily_cost_yujin.xls";
        string TempFile = "../../../system/temp/rpt_daily_cost_yujin_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

         //Create a new workbook
		IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

		//Add worksheet
		IWorksheet exSheet = exBook.Worksheets[1];
		IRange range;		
		MemoryStream stream;
		Bitmap b;

        string p_dept, p_status, p_work_dt;

        p_dept = Request["p_org"].ToString();
        p_status = Request["p_status"].ToString();
        p_work_dt = Request["p_1"].ToString();
       


#region cau sql
        string SQL 
	= "SELECT S.ORG_L2_NM C0,S.DEPT_NM C1,S.EMP_ID C2,S.FULL_NAME C3 " + 
        ",NVL(S.SALARY_LEVEL1,0) C4,NVL(S.SALARY_LEVEL2,0) C5 " +
        ",NVL(S.TOTAL_ALLOWANCE_L1,0) C6,NVL(S.TOTAL_ALLOWANCE_L2,0) C7 " +
        ",NVL(S.ALLOW_AMT2_L1,0) C8,NVL(S.ALLOW_AMT2_L2,0) C9 " +
        ",NVL(S.ALLOW_AMT1_L1,0) C10,NVL(S.ALLOW_AMT1_L2,0) C11 " +
        ",NVL(S.ALLOW_AMT4_L1,0) C12,NVL(S.ALLOW_AMT4_L2,0) C13 " +
        ",NVL(S.ALLOW_AMT3_L1,0) C14,NVL(S.ALLOW_AMT3_L2,0) C15 " +
       ",NVL(S.TOTAL_ABS_NPAY_L1,0) C16, NVL(S.TOTAL_ABS_NPAY_L2,0) C17  " +
        ",0 C18 " +
        ",ROUND(NVL(S.WT_L1,0)+NVL(S.TOTAL_ABS_PAY_L1,0)+NVL(S.HOL_DAY_L1,0)*8,2) C19  " +
        ",ROUND(NVL(S.WT_L2,0)+NVL(S.TOTAL_ABS_PAY_L2,0)+NVL(S.HOL_DAY_L2,0)*8,2) C20 " +
        ",ROUND(NVL(S.WT_L1_AMT,0)+NVL(S.WT_L2_AMT,0)+NVL(S.TOTAL_ABS_PAY_L1_AMT,0)+NVL(S.TOTAL_ABS_PAY_L2_AMT,0)+NVL(S.HOL_DAY_L1_AMT,0)+NVL(S.HOL_DAY_L2_AMT,0)) C21 " +
        ",NVL(S.OT_L1,0) C22,NVL(S.OT_L2,0) C23 " +
        ",NVL(S.OT_L1_AMT,0)+NVL(S.OT_L2_AMT,0) C24 " +
        ",NVL(S.ST_L1,0)+NVL(S.OST_L1,0) C25 " +
        ",NVL(S.ST_L2,0)+NVL(S.OST_L2,0) C26  " +
        ",NVL(S.ST_L1_AMT,0)+NVL(S.ST_L2_AMT,0)+NVL(S.OST_L1_AMT,0)+NVL(S.OST_L2_AMT,0) C27 " +
        ",NVL(S.HT_L1,0)+NVL(S.OHT_L1,0) C28  " +
        ",NVL(S.HT_L2,0)+NVL(S.OHT_L2,0) C29 " +
        ",NVL(S.HT_L1_AMT,0)+NVL(S.HT_L2_AMT,0)+NVL(S.OHT_L1_AMT,0)+NVL(S.OHT_L2_AMT,0) C30  " +
        ",NVL(S.NT_30_L1,0) C31, NVL(S.NT_30_L2,0) C32 " +
        ",NVL(S.NT_45_L1,0) C33, NVL(S.NT_45_L2,0) C34  " +
        ",NVL(S.NT_60_L1,0) C35, NVL(S.NT_60_L2,0) C36  " +
        ",NVL(S.NT_90_L1,0) C37, NVL(S.NT_90_L2,0) C38  " +
        ",NVL(S.NT_30_L1_AMT,0)+NVL(S.NT_30_L2_AMT,0)   " +
        "    +NVL(S.NT_45_L1_AMT,0)+NVL(S.NT_45_L2_AMT,0)  " +
        "    +NVL(S.NT_60_L1_AMT,0)+NVL(S.NT_60_L2_AMT,0)  " +
        "    +NVL(S.NT_90_L1_AMT,0)+NVL(S.NT_90_L2_AMT,0) C39  " +
        ",NVL(S.TOTAL_OT_L1_AMT,0)+NVL(S.TOTAL_OT_L2_AMT,0) C40 " +
        ",NVL(S.ALLOW_K3_AMT,0) C41,NVL(S.ALLOW_K2_AMT,0) C42,NVL(S.ALLOW_K1_AMT,0) C43  " +
        ",NVL(S.ALLOW_K4_AMT,0)+NVL(S.ALLOW_K5_AMT,0)+NVL(S.RETURN_PIT,0)+NVL(S.RETURN_OTHER,0) C44  " +
        ",NVL(S.INC_AMT,0) C45  " +
        ",ROUND(NVL(S.ALE_STOP,0),10) C46,ROUND(NVL(S.ALE_STOP_AMT,0),10) C47  " +
        ",ROUND(NVL(S.ADVANCE_AMT,0),10) C48,ROUND(NVL(S.INSURANCE_PAY,0)+NVL(S.SEVERANCE_AMT,0),10) C49  " +
        ",NVL(S.GROSS_AMT,0) C50  " +
        ",NVL(S.FAMILY_DEPEND,0) C51,ROUND(NVL(S.INCOME_BEFORE_TAX,0),10) C52  " +
        ",ROUND(NVL(S.INCOME_TAX,0),10) C53,ROUND(NVL(S.SOCIAL_AMT,0),10) C54,ROUND(NVL(S.HEALTH_AMT,0),10) C55,ROUND(NVL(S.UNEMP_INS,0),10) C56  " +
        ",ROUND(NVL(S.UNION_AMT,0),10) C57,ROUND(NVL(S.RETURN_NO_PIT,0)+NVL(S.RETURN_OTHER_NO_PIT,0),10) C58,ROUND(NVL(S.ADVANCE_NO_PIT,0),10) C59  " +
        ",ROUND(NVL(S.NET_AMT,0),10) C60,0 C61,ROUND(NVL(S.ENTRY_AMT,0),10) C62,NVL(S.SOCIAL_COMPANY,0) C68,NVL(S.HEALTH_COMPANY,0) C69,NVL(S.UNEMP_COM_INS,0) C70,NVL(S.UNION_COMPANY,0) C71 "+
        ",S.ORG_L2_NM C63,S.dept_nm C64,S.POS_NM C65  " +
        ",TO_CHAR(TO_DATE(S.JOIN_DT,'YYYYMMDD'),'DD/MM/YYYY') C66  " +
        ",S.OLD_ID C67 " + 
        "FROM THR_DAILY_SALARY_V2 S  " +
        "where s.del_if=0 and s.work_dt='" + p_work_dt + "' " +
        "and s.tco_dept_pk in ( " +
        "                              SELECT     g.pk " +
        "                                    FROM tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk = (case when '" + p_dept + "' = 'ALL' then g.pk else to_number('" + p_dept + "') end) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        " and decode('" + p_status + "','ALL','ALL',s.status)='" + p_status + "'" +
        " and nvl(s.net_amt,0)>0 "+
        " order by s.org_l2_nm,s.DEPT_NM,s.emp_id";


        DataTable dt_total = ESysLib.TableReadOpen(SQL);

# endregion

        //Response.Write(SQL);
		//Response.End();
        int pos = 9;
        int irow, icol;
        irow = dt_total.Rows.Count;
        icol = dt_total.Columns.Count;
        if (irow == 0)
        {
            Response.Write("There is no data");
            Response.End();
        }

        int i, tmp;
        int sub_num = 0;
         int t_num = 0;
        double[] grant_total = new double[icol + 1];
        double[] sub_total = new double[icol + 1];
        double[] t_total = new double[icol + 1];
        for (int k = 0; k < icol; k++)
        {
            grant_total[k] = 0;
            sub_total[k] = 0;
            t_total[k] = 0;
        }

        //Insert new row
        for (i = 0; i < irow - 1; i++)
        {
            exSheet.Range[pos + i + 1, 1].Rows.EntireRow.Insert();
        }
        tmp = 0;

        exSheet.Cells["A1"].Value = "CHI PHÍ NHÂN CÔNG THEO NGÀY - DAILY LABOR COST";
        exSheet.Cells["A2"].Value = "Ngày/ Date: " + p_work_dt.Substring(6, 2) + "/" + p_work_dt.Substring(4, 2) + "/" + p_work_dt.Substring(0, 4);
        //exSheet.Cells["A3"].Value = "Ngày in :" + DateTime.Now.ToString("dd/MM/yyyy");

        for (i = 0; i < irow; i++)
        {

            if (i == 0)//nguoi dau tien
            {
                exSheet.Cells["A7"].Value = dt_total.Rows[i][0].ToString();
                exSheet.Cells["A8"].Value = dt_total.Rows[i][1].ToString();
            }

                exSheet.Cells[pos + i+tmp, 1].Value = i + 1;
                sub_num += 1;
                t_num+=1;
            for (int j = 2; j < icol; j++)
            {
                if (j >=4 && j<icol-5)
                {
                    if (dt_total.Rows[i][j].ToString() != "" && dt_total.Rows[i][j].ToString() != "0")
                    {
                        exSheet.Cells[pos + i + tmp, j].Value = double.Parse(dt_total.Rows[i][j].ToString());
                        grant_total[j] += double.Parse(dt_total.Rows[i][j].ToString());
                        sub_total[j] += double.Parse(dt_total.Rows[i][j].ToString());
                        t_total[j] += double.Parse(dt_total.Rows[i][j].ToString());
                    }
                }
                else
                {
                    exSheet.Cells[pos + i + tmp, j].Value = dt_total.Rows[i][j].ToString();
                }
            }

           if (i < irow - 1)
            {

                 if (dt_total.Rows[i][0].ToString() != dt_total.Rows[i + 1][0].ToString()) //org_l2
                { 
                     //insert dong sub total
                     exSheet.Range[pos + i + tmp+1, 1].Rows.EntireRow.Insert();
                     exSheet.Cells[pos + i + tmp+1, 1, pos + i + tmp+1, 2].Merge();
                     exSheet.Cells[pos + i + tmp+1, 1, pos + i + tmp+1, icol].Rows.Font.Bold = true;
                     exSheet.Cells[pos + i + tmp + 1, 3].Value = sub_num+ " Nhân viên";
                     exSheet.Cells[pos + i + tmp + 1, 1].Value = "Sub Total";
                     //chay dong sub
                     for (int j = 4; j < icol-5; j++)
                    {
                        exSheet.Cells[pos + i + tmp + 1, j].Value = sub_total[j];
                        sub_total[j] = 0;
                        sub_num = 0;
                    }
                     tmp+=1;

                     //insert dong t total
                     exSheet.Range[pos + i + tmp+1, 1].Rows.EntireRow.Insert();
                     exSheet.Cells[pos + i + tmp+1, 1, pos + i + tmp+1, 2].Merge();
                     exSheet.Cells[pos + i + tmp+1, 1, pos + i + tmp+1, icol].Rows.Font.Bold = true;
                     exSheet.Cells[pos + i + tmp + 1, 3].Value = t_num+ " Nhân viên";
                     exSheet.Cells[pos + i + tmp + 1, 1].Value = "Total";
                     //chay dong t total
                     for (int j = 4; j < icol-5; j++)
                    {
                        exSheet.Cells[pos + i + tmp + 1, j].Value = t_total[j];
                        t_total[j] = 0;
                        t_num = 0;
                    }
                     tmp+=1;

                     //insert dong org_l2
                     exSheet.Range[pos + i + tmp + 1, 1].Rows.EntireRow.Insert();
                     exSheet.Cells[pos + i + tmp + 1, 1, pos + i + tmp + 1, icol].Rows.Font.Bold = true;
                     exSheet.Cells[pos + i + tmp + 1, 1].Value = dt_total.Rows[i + 1][0].ToString();
                     exSheet.Cells[pos + i + tmp + 1, 1].Rows.Font.Color = Color.FromArgb(255, 000, 000);
                     exSheet.Cells[pos + i + tmp + 1, 1].ShrinkToFit = false;
                     tmp += 1;

                     //insert dong dept
                     exSheet.Range[pos + i + tmp + 1, 1].Rows.EntireRow.Insert();
                     exSheet.Cells[pos + i + tmp + 1, 1, pos + i + tmp + 1, icol].Rows.Font.Bold = true;
                     exSheet.Cells[pos + i + tmp + 1, 1].Value = dt_total.Rows[i + 1][1].ToString();
                     exSheet.Cells[pos + i + tmp + 1, 1].ShrinkToFit = false;
                     exSheet.Cells[pos + i + tmp + 1, 1].Rows.Font.Color = Color.FromArgb(000, 000, 000);
                     tmp += 1;


                }
                 else if (dt_total.Rows[i][1].ToString() != dt_total.Rows[i + 1][1].ToString()) //dept name
                 {
                     //insert dong sub total
                     exSheet.Range[pos + i + tmp+1, 1].Rows.EntireRow.Insert();
                     exSheet.Cells[pos + i + tmp+1, 1, pos + i + tmp+1, 2].Merge();
                     exSheet.Cells[pos + i + tmp+1, 1, pos + i + tmp+1, icol].Rows.Font.Bold = true;
                     exSheet.Cells[pos + i + tmp + 1, 3].Value = sub_num+ " Nhân viên";
                     exSheet.Cells[pos + i + tmp + 1, 1].Value = "Sub Total";
                     //chay dong sub
                     for (int j = 4; j < icol-5; j++)
                    {
                        exSheet.Cells[pos + i + tmp + 1, j].Value = sub_total[j];
                        sub_total[j] = 0;
                        sub_num = 0;
                    }
                     tmp+=1;

                     //insert dong dept
                     exSheet.Range[pos + i + tmp + 1, 1].Rows.EntireRow.Insert();
                     exSheet.Cells[pos + i + tmp + 1, 1, pos + i + tmp + 1, icol].Rows.Font.Bold = true;
                     exSheet.Cells[pos + i + tmp + 1, 1].Value = dt_total.Rows[i + 1][1].ToString();
                     exSheet.Cells[pos + i + tmp + 1, 1].ShrinkToFit = false;
                     tmp += 1;
                     
                 }

            }

        }
        exSheet.Cells[pos + irow + tmp, 3].Value = sub_num + " Nhân viên";
        exSheet.Cells[pos + irow + tmp + 1, 3].Value = t_num + " Nhân viên";
        exSheet.Cells[pos + irow + tmp + 2, 3].Value = irow + " Nhân viên";
        //chay dong sub,total,grand cuoi
        for (int j = 4; j < icol - 5; j++)
        {
            exSheet.Cells[pos + irow + tmp , j].Value = sub_total[j];
            exSheet.Cells[pos + irow + tmp + 1, j].Value = t_total[j];
            exSheet.Cells[pos + irow + tmp + 2, j].Value = grant_total[j];
            
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
