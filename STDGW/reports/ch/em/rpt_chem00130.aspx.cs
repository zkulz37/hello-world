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

public partial class reports_ch_em_rpt_chem00130 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ESysLib.SetUser(Session["APP_DBUSER"].ToString());

        string p_eva_master_pk = Request["p_eva_master_pk"].ToString();
        string p_org_pk = Request["p_org_pk"].ToString();
        string p_emp_reviewer_pk = Request["p_emp_reviewer_pk"].ToString();
        string p_emp_id = Request["p_emp_id"].ToString();

        string TemplateFile = "rpt_chem00130.xls";
        string TempFile = "../../../system/temp/rpt_chem00130_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        string SQL
        = "select '','',org_nm, emp_id, full_name, join_dt, " +
        "               max((select CODE_NM FROM vhr_hr_code WHERE id = 'HR0102' and code = eva_emp_status)) eva_status, max(eva_rank) eva_rank, " +
        "               max(final_grade) final_grade, max(first_a) first_a, max(first_c) first_c, " +
        "               max(first_t) first_t, max(first_rank), max(first_grade), " +
        "               max(opinion_eva_1), max(opinion_pos_1), " +
        "               max(second_a) second_a, max(second_c) second_c, max(second_t) second_t, " +
        "               max(second_rank), max(second_grade), max(opinion_eva_2), max(opinion_pos_2) " +
        "          from (select a.thr_eva_emp_pk, d.org_id || '-' || d.org_nm org_nm, c.emp_id, c.full_name,to_char(to_date(c.join_dt,'yyyymmdd'),'dd/mm/yyyy') join_dt, " +
        "                       e.group_id || '-' || e.group_nm group_nm, b.eva_emp_status, a.eva_rank, b.final_grade, " +
        "                       b.a_self_score self_a, b.c_self_score self_c, b.t_self_score self_t, null first_a, " +
        "                       null first_c, null first_t, null first_rank, null first_grade, null opinion_eva_1, null opinion_pos_1, " +
        "                       null second_a, null second_c, null second_t, null second_rank, " +
        "                       null second_grade, null opinion_eva_2, null opinion_pos_2 " +
        "                  from thr_eva_emp_reviewer a, thr_eva_emp b, thr_employee c, " +
        "                       tco_org d, thr_eva_group e " +
        "                 where     a.thr_eva_emp_pk = b.pk " +
        "                       and b.del_if = 0 " +
        "                       and a.del_if = 0 " +
        "                       and b.thr_eva_master_pk = '41' " +
        "                       and a.thr_eva_emp_pk in (select y.thr_eva_emp_pk " +
        "                                 from thr_eva_reviewer x, thr_eva_emp_reviewer y " +
        "                                where     x.thr_employee_pk = '" + p_emp_reviewer_pk + "' " +
        "                                      and x.thr_eva_master_pk = '" + p_eva_master_pk + "' " +
        "                                      and x.del_if = 0 " +
        "                                      and y.del_if=0 " +
        "                                      and y.thr_eva_reviewer_pk = x.pk) " +
        "                       and d.pk in (    select pk " +
        "                                              from tco_org " +
        "                                             where del_if = 0 " +
        "                                        connect by prior pk = p_pk  " +
        "                                        start with pk = case when '" + p_org_pk + "'='ALL' then pk else to_number('" + p_org_pk + "') end) " +
        "                       and b.thr_employee_pk = c.pk " +
        "                       and c.tco_org_pk = d.pk " +
        "                       and b.thr_eva_group_pk = e.pk " +
        "                       and e.mbo_yn = 'Y' " +
        "                       and (c.emp_id like '%' || '" + p_emp_id + "' || '%' " +
        "                            or c.full_name like '%' || '" + p_emp_id + "' || '%') " +
        "                union all " +
        "                select a.thr_eva_emp_pk, d.org_id || '-' || d.org_nm, c.emp_id, c.full_name,to_char(to_date(c.join_dt,'yyyymmdd'),'dd/mm/yyyy') join_dt, " +
        "                       e.group_id || '-' || e.group_nm, b.eva_emp_status, a.eva_rank, b.final_grade, " +
        "                       null, null, null, a_score first_a, " +
        "                       c_score first_c, t_score first_t, a.eva_rank first_rank, a.grade first_grade, " +
        "                       A.OPINION_EVALUATION opinion_eva_1, A.OPINION_POSITION opinion_pos_1, " +
        "                       null, null, null, null, " +
        "                       null, null, null " +
        "                  from thr_eva_emp_reviewer a, thr_eva_emp b, thr_employee c, " +
        "                       tco_org d, thr_eva_group e " +
        "                 where a.thr_eva_emp_pk = b.pk and b.del_if = 0 " +
        "                       and a.thr_eva_emp_pk in " +
        "                              (select y.thr_eva_emp_pk " +
        "                                 from thr_eva_reviewer x, thr_eva_emp_reviewer y " +
        "                                where     x.thr_employee_pk = '" + p_emp_reviewer_pk + "' " +
        "                                      and x.thr_eva_master_pk = '" + p_eva_master_pk + "' " +
        "                                      and x.del_if = 0 " +
        "                                      and y.del_if = 0 " +
        "                                      and y.thr_eva_reviewer_pk = x.pk) " +
        "                       and d.pk in (    select pk " +
        "                                              from tco_org " +
        "                                             where del_if = 0 " +
        "                                        connect by prior pk = p_pk  " +
        "                                        start with pk = case when '" + p_org_pk + "'='ALL' then pk else to_number('" + p_org_pk + "') end) " +
        "                       and b.thr_eva_master_pk = '" + p_eva_master_pk + "' " +
        "                       and b.thr_employee_pk = c.pk " +
        "                       and a.del_if=0 " +
        "                       and c.tco_org_pk = d.pk " +
        "                       and b.thr_eva_group_pk = e.pk " +
        "                       and a.reviewer_level = 1 " +
        "                       and (c.emp_id like '%' || '" + p_emp_id + "' || '%' " +
        "                            or c.full_name like '%' || '" + p_emp_id + "' || '%') " +
        "                union all " +
        "                select a.thr_eva_emp_pk, d.org_id || '-' || d.org_nm, c.emp_id, c.full_name,to_char(to_date(c.join_dt,'yyyymmdd'),'dd/mm/yyyy') join_dt, " +
        "                       e.group_id || '-' || e.group_nm, b.eva_emp_status, a.eva_rank, b.final_grade, " +
        "                       null, null, null, null, " +
        "                       null, null, null, null,null,null, " +
        "                       a_score second_a, c_score second_c, t_score second_t, a.eva_rank second_rank, " +
        "                       a.grade second_grade,A.OPINION_EVALUATION opinion_eva_2, A.OPINION_POSITION opinion_pos_2 " +
        "                  from thr_eva_emp_reviewer a, thr_eva_emp b, thr_employee c, " +
        "                       tco_org d, thr_eva_group e, thr_eva_reviewer f " +
        "                 where     a.thr_eva_emp_pk = b.pk " +
        "                       and b.del_if = 0 " +
        "                       and a.del_if = 0 " +
        "                       and a.thr_eva_reviewer_pk = f.pk " +
        "                       and f.thr_employee_pk = '" + p_emp_reviewer_pk + "' " +
        "                       and b.thr_eva_master_pk = '" + p_eva_master_pk + "' " +
        "                       and d.pk in (    select pk " +
        "                                              from tco_org " +
        "                                             where del_if = 0 " +
        "                                        connect by prior pk = p_pk  " +
        "                                        start with pk = case when '" + p_org_pk + "'='ALL' then pk else to_number('" + p_org_pk + "') end) " +
        "                       and b.thr_employee_pk = c.pk " +
        "                       and c.tco_org_pk = d.pk " +
        "                       and b.thr_eva_group_pk = e.pk " +
        "                       and a.reviewer_level = 2 " +
        "                       and (c.emp_id like '%' || '" + p_emp_id + "' || '%' " +
        "                            or c.full_name like '%' || '" + p_emp_id + "' || '%')) " +
        "      group by org_nm, " +
        "               emp_id, " +
        "               full_name,join_dt, " +
        "               group_nm ";


        //Response.Write(SQL);
        //Response.End();

        DataTable dt_emp = ESysLib.TableReadOpen(SQL);
        int irow, icol;
        irow = dt_emp.Rows.Count;
        icol = dt_emp.Columns.Count;

        if (irow == 0)
        {
            Response.Write("There is no data");
            Response.End();
        }

        SQL
        = "SELECT EVA_YYYY || '-' || EVA_SEQ times_eva" +
        "  FROM THR_EVA_MASTER " +
        " WHERE DEL_IF = 0 AND PK = '" + p_eva_master_pk + "' ";

        DataTable dt_time_eva = ESysLib.TableReadOpen(SQL);


        int i, j, k, i_allow;
        int pos = 7;
        
        //bind data to excel file
        //-----header---   

        exSheet.Cells["B2"].Value = "Times: " + dt_time_eva.Rows[0][0].ToString();


        //---end--header---
        //Insert new row

        for (i = 0; i < irow - 1; i++)
        {
            exSheet.Range[pos + 1, 1].Rows.EntireRow.Insert();
        }

        //Show data
        for (i = 0; i < irow; i++)
        {
            exSheet.Cells[pos + i, 1].Value = i + 1;
            for (j = 2; j < icol; j++)
                exSheet.Cells[pos + i, j].Value = dt_emp.Rows[i][j].ToString();

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
}