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

public partial class rpt_month_sal_change : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ESysLib.SetUser(Session["APP_DBUSER"].ToString());

        string TemplateFile = "rpt_month_sal_change.xls";
        string TempFile = "../../../system/temp/rpt_month_sal_change_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        // ------------ BEGIN REPORT -------------

        string p_tco_org_pk, p_thr_wg_pk, p_position, p_search_by, p_search_temp, p_nation;
        string p_contract_type, p_status, p_from_mod_dt, p_to_mod_dt, p_money, p_from_sal_mon, p_to_sal_mon;

        p_tco_org_pk = Request["org"].ToString();
        p_thr_wg_pk = Request["wg"].ToString();
        p_position = Request["pos"].ToString();
        p_search_by = Request["lsttmp"].ToString();
        p_search_temp = Request["txttmp"].ToString();
        p_nation = Request["nation"].ToString();
        p_contract_type = Request["contract"].ToString();
        p_status = Request["status"].ToString();
        p_from_mod_dt = Request["fromModDate"].ToString();
        p_to_mod_dt = Request["toModDate"].ToString();
        p_money = Request["lstmoney"].ToString();
        p_from_sal_mon = Request["fromSalMon"].ToString();
        p_to_sal_mon = Request["toSalMon"].ToString();

        string SQL_allow
     = "SELECT MAX (code1), MAX (code2), MAX (code3), MAX (code4), MAX (code5), " +
         "             MAX (code6), MAX (code7), MAX (code8), MAX (c1), MAX (c2), " +
         "             MAX (c3), MAX (c4), MAX (c5), MAX (c6), MAX (c7), MAX (c8) " +
         "        FROM (SELECT DECODE (code, 'A1', a.code_nm, '') AS code1, " +
         "                     DECODE (code, 'A2', a.code_nm, '') AS code2, " +
         "                     DECODE (code, 'A3', a.code_nm, '') AS code3, " +
         "                     DECODE (code, 'A4', a.code_nm, '') AS code4, " +
         "                     DECODE (code, 'A5', a.code_nm, '') AS code5, " +
         "                     DECODE (code, 'A6', a.code_nm, '') AS code6, " +
         "                     DECODE (code, 'A7', a.code_nm, '') AS code7, " +
         "                     DECODE (code, 'A8', a.code_nm, '') AS code8, " +
         "                     DECODE (code, 'A1', a.num_2, '') AS c1, " +
         "                     DECODE (code, 'A2', a.num_2, '') AS c2, " +
         "                     DECODE (code, 'A3', a.num_2, '') AS c3, " +
         "                     DECODE (code, 'A4', a.num_2, '') AS c4, " +
         "                     DECODE (code, 'A5', a.num_2, '') AS c5, " +
         "                     DECODE (code, 'A6', a.num_2, '') AS c6, " +
         "                     DECODE (code, 'A7', a.num_2, '') AS c7, " +
         "                     DECODE (code, 'A8', a.num_2, '') AS c8 " +
         "                FROM vhr_hr_code a " +
         "               WHERE a.ID = 'HR0019') allow_amt ";

        //Response.Write(SQL_lable);
        //Response.End();
        DataTable myDT = new DataTable();
        myDT = ESysLib.TableReadOpen(SQL_allow);


      //  int t = 0;
        int count_allow = 0;
        int col_allow = 13;
        for (int i = 8; i < myDT.Columns.Count; i++)
        {
            if (myDT.Rows[0][i].ToString() == "1") //co dung
            {
                exSheet.Cells[7, col_allow + i - 8].Value = myDT.Rows[0][i - 8].ToString() + "-L1";                
                //exSheet.Cells[7, 12 + i - 8].Rows.Font.Bold = true;
                //exSheet.Cells[7, 12 + i - 8].Borders.LineStyle = XlLineStyle.xlContinuous;
                //exSheet.Cells[8, 12 + i - 8].Borders.LineStyle = XlLineStyle.xlContinuous;
                //exSheet.Cells[7, 12 + i - 8].ColumnWidth = 15;
                //exSheet.Cells[7, 12 + i - 8].Interior.Color = System.Drawing.Color.SkyBlue;

                exSheet.Cells[7, col_allow + i - 8 + 1].Value = myDT.Rows[0][i - 8].ToString() + "-L2";
                //exSheet.Cells[7, 12 + i - 8 +1].Rows.Font.Bold = true;
                //exSheet.Cells[7, 12 + i - 8 +1].Borders.LineStyle = XlLineStyle.xlContinuous;
                //exSheet.Cells[8, 12 + i - 8 + 1].Borders.LineStyle = XlLineStyle.xlContinuous;
                //exSheet.Cells[7, 12 + i - 8 +1].ColumnWidth = 15;
                //exSheet.Cells[7, 12 + i - 8 + 1].Interior.Color = System.Drawing.Color.SkyBlue;

                //count_allow = count_allow + 2;
                //t += 1;
            }
        }
        
        //
        //exSheet.Cells[7, 12 + count_allow].Value = "Remark Mod Sal";
        //exSheet.Cells[7, 12 + count_allow].Rows.Font.Bold = true;
        //exSheet.Cells[7, 12 + count_allow].Borders.LineStyle = XlLineStyle.xlContinuous;
        //exSheet.Cells[8, 12 + count_allow].Borders.LineStyle = XlLineStyle.xlContinuous;
        //exSheet.Cells[7, 12 + count_allow].ColumnWidth = 50;
        //exSheet.Cells[7, 12 + count_allow].Interior.Color = System.Drawing.Color.SkyBlue;

        //exSheet.Cells[7, 12 + count_allow + 1].Value = "Create by";
        //exSheet.Cells[7, 12 + count_allow + 1].Rows.Font.Bold = true;
        //exSheet.Cells[7, 12 + count_allow + 1].Borders.LineStyle = XlLineStyle.xlContinuous;
        //exSheet.Cells[8, 12 + count_allow + 1].Borders.LineStyle = XlLineStyle.xlContinuous;
        //exSheet.Cells[7, 12 + count_allow + 1].ColumnWidth = 15;
        //exSheet.Cells[7, 12 + count_allow + 1].Interior.Color = System.Drawing.Color.SkyBlue;

        //exSheet.Cells[7, 12 + count_allow + 2].Value = "Create date";
        //exSheet.Cells[7, 12 + count_allow + 2].Rows.Font.Bold = true;
        //exSheet.Cells[7, 12 + count_allow + 2].Borders.LineStyle = XlLineStyle.xlContinuous;
        //exSheet.Cells[8, 12 + count_allow + 2].Borders.LineStyle = XlLineStyle.xlContinuous;
        //exSheet.Cells[7, 12 + count_allow + 2].ColumnWidth = 25;
        //exSheet.Cells[7, 12 + count_allow + 2].Interior.Color = System.Drawing.Color.SkyBlue;

        //exSheet.Cells[7, 12 + count_allow + 3].Value = "Work mon";
        //exSheet.Cells[7, 12 + count_allow + 3].Rows.Font.Bold = true;
        //exSheet.Cells[7, 12 + count_allow + 3].Borders.LineStyle = XlLineStyle.xlContinuous;
        //exSheet.Cells[8, 12 + count_allow + 3].Borders.LineStyle = XlLineStyle.xlContinuous;
        //exSheet.Cells[7, 12 + count_allow + 3].ColumnWidth = 25;
        //exSheet.Cells[7, 12 + count_allow + 3].Interior.Color = System.Drawing.Color.SkyBlue;

        string SQL
    = "select b.org_nm,C.WORKGROUP_NM,D.EMP_ID,D.FULL_NAME " +
        "                    ,to_char(to_date( D.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy')                      " +
        "                    ,TO_CHAR(to_date(A.WORK_MON,'yyyymm'),'mm/yyyy')                     " +
        "                    ,A.MOD_SAL_BY                    " +
        "                    ,to_char(A.MOD_SAL_DT,'dd/mm/yyyy HH24:MI:SS') " +
        "                    ,A.SALARY_LEVEL1,A.SALARY_LEVEL2 " +
        "                    ,to_char(to_date(a.CONFIRM_DT,'yyyymmdd'),'dd/mm/yyyy')         " +
        "                    ,A.ALLOW_AMT1_L1 " +
        "                    ,A.ALLOW_AMT1 " +
        "                    ,A.ALLOW_AMT2_L1 " +
        "                    ,A.ALLOW_AMT2 " +
        "                    ,A.ALLOW_AMT3_L1 " +
        "                    ,A.ALLOW_AMT3 " +
        "                    ,A.ALLOW_AMT4_L1 " +
        "                    ,A.ALLOW_AMT4 " +
        "                    ,A.ALLOW_AMT5_L1 " +
        "                    ,A.ALLOW_AMT5 " +
        "                    ,A.ALLOW_AMT6_L1 " +
        "                    ,A.ALLOW_AMT6 " +
        "                    ,A.ALLOW_AMT7_L1 " +
        "                    ,A.ALLOW_AMT7 " +
        "                    ,A.ALLOW_AMT8_L1 " +
        "                    ,A.ALLOW_AMT8 " +
        "                    ,A.REMARK_MOD_SAL                     " +
        "                    ,A.CRT_BY " +
        "                    , to_char(a.CRT_DT,'dd/mm/yyyy HH24:MI:SS') " +       
        "            ,to_char(to_date('" + p_from_mod_dt + "','yyyymmdd'),'dd/mm/yyyy') as ModDate_from " +
        "            ,to_char(to_date('" + p_to_mod_dt + "','yyyymmdd'),'dd/mm/yyyy') as ModDate_to " +
        "            ,to_char(sysdate,'dd/mm/yyyy') as sysdt " +
        "        from THR_SALARY_MANAGE a,tco_org b,thr_work_group c,thr_employee d " +
        "        where a.del_if=0                        " +
        "                 and ( '" + p_from_sal_mon + "' IS NULL OR '" + p_to_sal_mon + "' IS NULL " +
        "                        OR A.WORK_MON BETWEEN  '" + p_from_sal_mon + "' AND '" + p_to_sal_mon + "' " +
        "                       ) " +
        "                 and b.del_if=0 and  A.TCO_ORG_PK=b.pk " +
        "                 and c.del_if=0 and A.THR_WG_PK=c.pk " +
        "                 and d.del_if=0 and A.THR_EMP_PK=d.pk " +
        "                 and (d.tco_org_pk IN (SELECT  g.pk " +
        "                                    FROM tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk =DECODE ('" + p_tco_org_pk + "','ALL', 0,'" + p_tco_org_pk + "') " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_tco_org_pk + "' = 'ALL') " +
        "                and decode ('" + p_thr_wg_pk + "','ALL','" + p_thr_wg_pk + "',d.THR_WG_PK) ='" + p_thr_wg_pk + "' " +
        "                and decode ('" + p_position + "', 'ALL', '" + p_position + "', d.POS_TYPE) = '" + p_position + "' " +
        "                and UPPER (DECODE ('" + p_search_by + "',1, d.full_name,2, d.emp_id,d.id_num)) LIKE '%' || UPPER ('" + p_search_temp + "') || '%' " +
        "                and decode ('" + p_nation + "', 'ALL', '" + p_nation + "', d.NATION) = '" + p_nation + "' " +
        "                AND DECODE ('" + p_contract_type + "','ALL', '" + p_contract_type + "',d.CONTRACT_TYPE) = '" + p_contract_type + "' " +
        "                and decode('" + p_status + "', 'ALL', 'ALL', d.STATUS) = '" + p_status + "'" +
        "                and decode ('" + p_money + "', 'ALL', '" + p_money + "', d.MONEY_KIND) = '" + p_money + "' " +
        "                and ('" + p_from_mod_dt + "' IS NULL OR '" + p_to_mod_dt + "' IS NULL  " +
        "                   OR to_char(A.MOD_SAL_DT,'yyyymmdd') BETWEEN '" + p_from_mod_dt + "' AND '" + p_to_mod_dt + "' ) " +
        "        order by A.WORK_MON desc,a.emp_id,A.MOD_SAL_DT DESC " ;

        //Response.Write(SQL_lable);
        //Response.End();
        DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
        int irow_emp, icol_emp;
        irow_emp = dt_Emp.Rows.Count;
        icol_emp = dt_Emp.Columns.Count;

        if (irow_emp == 0)
        {
            Response.Write("There is no data to print.");
            Response.End();
        }


        //insert row
        int pos_row = 8;
        for (int i = 0; i < irow_emp - 1; i++)
        {

            exSheet.Range[pos_row + i + 1, 1].Rows.EntireRow.Insert();
        }

        // show data
        int n1 = 8, n2 = 9; // luơng muc 1,2
        int n3 = 11, n4 = 12, n5 = 13, n6 = 14, n7 = 15, n8 = 16, n9 = 17, n10 = 18, n11 = 19, n12 = 20, n13 = 21, n14 = 22, n15 = 23, n16 = 24, n17 = 25, n18 = 26; // allowance level 1,2
        for (int i = 0; i < irow_emp; i++)
        {
            exSheet.Cells[pos_row + i, 1].Value = i + 1;
            for (int j = 0; j < icol_emp - 2; j++)
            {
                exSheet.Cells[pos_row + i, j + 2].Value = dt_Emp.Rows[i][j].ToString();
                if (j == n1 || j == n2 || j == n3 || j == n4 || j == n5 || j == n6 || j == n7 || j == n8 || j == n9 || j == n10 || j == n11 || j == n12 || j == n13 || j == n14 || j == n15 || j == n16 || j == n17 || j == n18)
                {
                    if (IsNumeric(dt_Emp.Rows[i][j].ToString()))
                    {
                        exSheet.Cells[pos_row + i, j + 2].Value = double.Parse(dt_Emp.Rows[i][j].ToString());
                    }
                }
                else
                {
                    exSheet.Cells[pos_row + i, j + 2].Value = dt_Emp.Rows[i][j].ToString();
                }
            }
        }

        //delete allowance
        //int pos_col_allow = 12;
        for (int i = 8; i < myDT.Columns.Count; i++)
        {
            if (myDT.Rows[0][i].ToString() == "1") //co dung
            {
                col_allow = col_allow + 2;
            }
            else
            {
                exSheet.Cells[7, col_allow, 7, col_allow].EntireColumn.Delete();
                exSheet.Cells[7, col_allow, 7, col_allow].EntireColumn.Delete();
            }
        }

        //title        
        exSheet.Cells[2, 1].Value = "Modify date from: " + dt_Emp.Rows[0]["ModDate_from"].ToString() + " to " + dt_Emp.Rows[0]["ModDate_to"].ToString();
        exSheet.Cells[4, 3].Value = dt_Emp.Rows[0]["sysdt"].ToString();
        exSheet.Cells[5, 3].Value = Session["User_ID"].ToString();
        // ---------------- END REPORT --------------------

        // end loop detail percent
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