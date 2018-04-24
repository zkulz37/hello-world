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

public partial class reports_ch_cs_rpt_employee_payroll_shb : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
        string TemplateFile = "rpt_employee_payroll_shb.xls";
        string TempFile = "../../../system/temp/rpt_employee_payroll_shb_" + DateTime.Now.ToString("hhmmss") +Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        string p_dept, p_group, p_status, p_type, p_pay_type, p_emp_id, p_work_mon, p_m_type, p_sal_period, p_emp_type, p_from_leftdate, p_to_leftdate;
        p_dept = Request["l_dept"].ToString();
        p_group = Request["l_group"].ToString();
        p_status = Request["l_status"].ToString();
        p_type = Request["l_type"].ToString();
        p_pay_type = Request["l_pay_type"].ToString();
        p_emp_id = Request["l_emp_id"].ToString();
        p_work_mon = Request["l_work_mon"].ToString();
        p_sal_period = Request["l_sal_period"].ToString();
        //p_emp_type = Request["l_Emp_Type"].ToString();
        p_m_type = Request.QueryString["l_m_type"].ToString();

        if (p_type == "ALL")
            p_type = "=nvl(a.net_amt,0)";

        string SQL
    = "select null,null, " +
        "       a.emp_id, " +
        "       a.full_name, " +
        "       a.dept_nm, " +
        "       to_char( to_date( a.join_dt, 'yyyymmdd' ), 'dd/mm/yyyy' ) join_dt, " +
        "       e.sex, " +
        "       a.grade_cd, " +
        "       a.sal_with_wt_l2, " +
        "       round( a.sal_with_wt_l2 / nvl( a.exchange_rate, 1 ), 2 ) sal_with_wt_l2_usd, " +
        "       round( nvl( a.total_wt_ht_abs, 0 ) / 8, 5 ) total_wt_ht_abs, " +
        "       round( nvl( a.total_wt_ht_abs_amt, 0 ), 5 ) total_wt_ht_abs_amt, " +
        "       round( nvl( d.allow_amt1, 0 ), 5 ) allow_amt1_full, " +
        "       round( nvl( a.allow_amt1, 0 ), 5 ) allow_amt1, " +
        "       round( nvl( a.total_wt_ht_abs_meal, 0 )/8, 5 ) total_wt_ht_abs_meal, " +
        "       round( nvl( a.allow_amt2, 0 ), 5 ) allow_amt2, " +
        "       round( nvl( a.ot_l1, 0 ) + nvl( a.ot_l2, 0 ), 5 ) ot, " +
        "       round( nvl( a.st_l1, 0 ) + nvl( a.st_l2, 0 ) + nvl( a.ost_l1, 0 ) + nvl( a.ost_l2, 0 ), 5 ) st, " +
        "       round( nvl( a.ht_l1, 0 ) + nvl( a.ht_l2, 0 ) + nvl( a.oht_l1, 0 ) + nvl( a.oht_l2, 0 ), 5 ) ht, " +
        "       round( nvl( a.nt_30_l1, 0 ) + nvl( a.nt_30_l2, 0 ), 5 ) ot, " +
        "       round( nvl( a.nt_45_l1, 0 ) + nvl( a.nt_45_l2, 0 ), 5 ) nt_45, " +
        "       round( nvl( a.nt_45_2_l1, 0 ) + nvl( a.nt_45_2_l2, 0 ), 5 ) nt_45_2, " +
        "       round( nvl( a.nt_60_l1, 0 ) + nvl( a.nt_60_l2, 0 ), 5 ) nt_60, " +
        "       round( nvl( a.nt_90_l1, 0 ) + nvl( a.nt_90_l2, 0 ), 5 ) nt_90, " +
        "       round( nvl( a.total_ot_l1_amt, 0 ) + nvl( total_ot_l2_amt, 0 ), 5 ) total_ot_amt, " +
        "       round( nvl( a.severance_amt, 0 ), 5 ) severance_amt, " +
        "       round( nvl( a.ale_stop, 0 ), 5 ) ale_stop, " +
        "       round( nvl( a.ale_stop_amt, 0 ), 5 ) ale_stop_amt, " +
        "       round( nvl(return_amt,0) + nvl( a.return_ot_salary,0 ) " +
        "     			+ nvl( a.return_position_allow,0 )" +
        "     			+ nvl( a.return_resign_allow,0 )" +
        "    			+ nvl( a.return_wt_salary,0 ), 5 ) total_return_amt, " +
        "       round( nvl( nvl(deduct_wt_salary,0), 0 )  , 5 ) deduct_wt_salary , " +
        "       round( nvl( a.gross_amt, 0 ), 5 ) gross_amt, " +
        "       round( nvl( a.total_ot_l1_amt, 0 ) + nvl( total_ot_l2_amt, 0 ) - nvl( a.ot_tax_l1_amt, 0 ) - nvl( a.ot_tax_l2_amt, 0 ), 5 ) ot_no_tax_amt, " +
        "       round( nvl( a.tax_payer_amt, 0 ), 5 ) tax_payer_amt, " +
        "       round( nvl( a.family_depend, 0 ), 5 ) family_depend, " +
        "       round( nvl( a.family_depend_amt, 0 ), 5 ) family_depend_amt, " +
        "       round( nvl( a.social_amt, 0 ), 5 ) social_amt, " +
        "       round( nvl( a.health_amt, 0 ), 5 ) health_amt, " +
        "       round( nvl( a.unemp_ins, 0 ), 5 ) unemp_ins, " +
        "       round( nvl( a.social_amt, 0 ) + nvl( a.health_amt, 0 ) + nvl( a.unemp_ins, 0 ), 5 ) total_ins_amt, " +
        "       round( nvl( a.return_no_pit, 0 ), 5 ) return_no_pit, " +
        "       round( nvl( a.advance_no_pit, 0 ), 5 ) advance_no_pit, " +
        "       round( nvl( 730000, 0 ), 5 ) meal_tax, " +
        "       round( nvl( a.income_amt, 0 ), 5 ) income_amt, " +
        "       round( nvl( a.tax_rate, 0 )/100, 5 ) tax_rate, " +
        "       round( nvl( a.min_tax, 0 ), 5 ) min_tax, " +
        "       round( nvl( a.income_tax, 0 ), 5 ) income_tax, " +
        "       round( nvl( a.social_company, 0 ), 5 ) social_company, " +
        "       round( nvl( a.health_company, 0 ), 5 ) health_company, " +
        "       round( nvl( a.unemp_com_ins, 0 ), 5 ) unemp_com_ins, " +
        "       round( nvl( a.social_company, 0 ) + nvl( a.health_company, 0 ) + nvl( a.unemp_com_ins, 0 ), 5 ) ins_com_amt, " +
        "       round( nvl( a.union_amt, 0 ), 5 ) union_amt, " +
        "       round( nvl( a.net_amt, 0 ), 5 ) net_amt, " +
        "       round( nvl( a.max_salary_si, 0 ), 5 ) max_salary_si, " +
        "       round( nvl( a.max_salary_ui, 0 ), 5 ) max_salary_ui, " +
		"		'' as REMRAK,"+
		"		to_char(to_date(a.left_dt,'YYYYMMDD'),'DD/MM/YYYY') as left_dt "+
        "from   thr_month_salary a, " +
        "       tco_org b, " +
        "       thr_work_group c, " +
        "       thr_salary_manage d, " +
        "       thr_employee e " +
        "where  a.del_if = 0 " +
        "and    d.del_if(+) = 0 " +
        "and    a.work_mon = '" + p_work_mon + "' " +
        "and    b.del_if = 0 " +
        "and    c.del_if = 0 " +
        "and    e.del_if = 0 " +
        "and    e.pk = a.thr_emp_pk " +
        "and    a.tco_dept_pk = b.pk " +
        "and    a.thr_emp_pk = d.thr_emp_pk(+) " +
        "and    a.work_mon = d.work_mon(+) " +
        "and    a.thr_group_pk = c.pk "+
        "         AND (   a.tco_dept_pk IN " +
        "                    (    SELECT g.pk " +
        "                           FROM tco_org g " +
        "                          WHERE g.del_if = 0 " +
        "                     START WITH g.pk = DECODE ('" + p_dept + "', 'ALL', 0, '" + p_dept + "') " +
        "                     CONNECT BY PRIOR g.pk = g.p_pk) " +
        "              OR '" + p_dept + "' = 'ALL') " +
        "         AND DECODE ('" + p_group + "', 'ALL', 'ALL', a.thr_group_pk) = '" + p_group + "' " +
        "         AND a.emp_id LIKE '%" + p_emp_id + "%' " +
        "         AND DECODE ('" + p_status + "', 'ALL', 'ALL', a.status) = '" + p_status + "' " +
        "         AND DECODE ('" + p_pay_type + "', 'ALL', 'ALL', a.pay_type) = '" + p_pay_type + "' " +
        "         AND DECODE ('" + p_m_type + "', 'ALL', 'ALL', a.MONEY_KIND) = '" + p_m_type + "' " +
        "         AND DECODE ('" + p_sal_period + "', 'ALL', 'ALL', a.sal_period) = '" + p_sal_period + "' " +
        "         AND NVL (a.net_amt, 0) " + p_type +
        " order by  a.emp_id ";



        //Response.Write(SQL);
        //Response.End();

        DataTable dt_emp = ESysLib.TableReadOpen(SQL);
        int irow_emp, icol_emp;
        irow_emp = dt_emp.Rows.Count;
        icol_emp = dt_emp.Columns.Count;

        if (irow_emp == 0)
        {
            Response.Write("There is no data of salary");
            Response.End();
        }

        //--------------------company information-----------------------
        string SQL_Com
        = "select  a.PARTNER_LNAME,a.ADDR1,a.PHONE_NO,a.TCO_BPPHOTO_PK,to_char(to_date('" + p_work_mon + "','yyyymm'),'MON-YYYY'),to_char(to_date('" + p_work_mon + "','yyyymm'),'MM-YYYY') " +
            "from tco_company a " +
            "where a.DEL_IF=0 " +
            "and a.pk in ( select tco_company_pk from  " +
            "               tco_org  f " +
            "               where  f.pk IN ( " +
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
            "and rownum=1 ";


        DataTable dt_Com = ESysLib.TableReadOpen(SQL_Com);
        int irow_com;
        irow_com = dt_Com.Rows.Count;

        //khai bao bien
        string cur_grp, next_grp;
        int pos = 9, n_dept = 0, count = 0;
        int flag = 1;
        int flag2 = 1;
        double[] grp_total = new double[icol_emp];
        double[] div_total = new double[icol_emp];
        double[] grd_total = new double[icol_emp];


        DateTime _mon_yyyy = new DateTime(int.Parse(p_work_mon.Substring(0, 4)), int.Parse(p_work_mon.Substring(4, 2)), 1);
        //_mon_yyyy.ToString()

        exSheet.Cells["A2"].Value = "21- " + dt_Com.Rows[0][4].ToString();
        

        /*for (int i = 0; i < irow_emp - 1; i++)
        {
            if (dt_emp.Rows[i]["dept_nm"].ToString() != dt_emp.Rows[i + 1]["dept_nm"].ToString())
                n_dept++;
        }/**/

        //Insert row
        for (int i = 0; i < irow_emp - 1 + n_dept; i++)
        {
            exSheet.Range[pos + 1, 1].Rows.EntireRow.Insert();
        }

        //Show data
        for (int i = 0; i < irow_emp; i++)
        {            
            count++;
            exSheet.Cells[pos, 1].Value = count;
            for (int j = 2; j < icol_emp; j++)
            {
                if (j <= 7 ||  j >= icol_emp-2)
                {
                    exSheet.Cells[pos, j].Value = dt_emp.Rows[i][j].ToString();
                }
                else
                {
                    exSheet.Cells[pos, j].Value = double.Parse(dt_emp.Rows[i][j].ToString());
                    //grp_total[j] += double.Parse(dt_emp.Rows[i][j].ToString());
                    //div_total[j] += double.Parse(dt_emp.Rows[i][j].ToString());
                    grd_total[j] += double.Parse(dt_emp.Rows[i][j].ToString());
                }
            }           
            pos++;
        }

        //exSheet.Range[pos, 1].Rows.EntireRow.Insert();
        exSheet.Cells[pos, 1, pos, 7].Merge();
        exSheet.Cells[pos, 1, pos, icol_emp].Rows.Font.Bold = true;
        exSheet.Cells[pos, 1].Value = "GRAND TOTAL ";
        for (int k = 8; k < icol_emp; k++)
        {
            exSheet.Cells[pos, k].Value = grd_total[k];

            grp_total[k] = 0;
        }/**/

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
}