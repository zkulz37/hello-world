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
public partial class reports_ch_ae_rpt_employee_detail_list : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ESysLib.SetUser(Session["APP_DBUSER"].ToString());

        string p_thr_group_pk, p_nation, p_search_by, p_search_temp, p_from_joindate, p_to_joindate;
        string p_salary_yn, p_position, p_pay_type, p_contract_kind, p_from_contract, p_to_contract;
        string p_sex, p_insurance_yn, p_status, p_from_leftdate, p_to_leftdate, p_from_birthdate;
        string p_ot_yn, p_to_birthdate, p_tco_dept_pk, p_sal_security, p_union;
        string p_user;
        string p_job, p_education, p_lstEmpKind, p_lstProject, p_wg, p_birth_month;

        p_user = Request["p_user"].ToString();
        p_thr_group_pk = Request["p1"].ToString();
        p_nation = Request["p2"].ToString();
        p_search_by = Request["p3"].ToString();
        p_search_temp = Request["p4"].ToString();
        p_from_joindate = Request["p5"].ToString();
        p_to_joindate = Request["p6"].ToString();
        p_salary_yn = Request["p7"].ToString();
        p_position = Request["p8"].ToString();
        p_pay_type = Request["p9"].ToString();
        p_contract_kind = Request["p10"].ToString();
        p_from_contract = Request["p11"].ToString();
        p_to_contract = Request["p12"].ToString();
        p_sex = Request["p13"].ToString();
        p_insurance_yn = Request["p14"].ToString();
        p_status = Request["p15"].ToString();
        p_from_leftdate = Request["p16"].ToString();
        p_to_leftdate = Request["p17"].ToString();
        p_from_birthdate = Request["p18"].ToString();
        p_ot_yn = Request["p19"].ToString();
        p_to_birthdate = Request["p20"].ToString();
        p_tco_dept_pk = Request["p21"].ToString();
        p_sal_security = Request["p22"].ToString();

        p_job = Request["p23"].ToString();
        p_education = Request["p24"].ToString();
        p_union = Request["p25"].ToString();
        p_birth_month = Request["p26"].ToString();

        string TemplateFile = "rpt_employee_detail_list.xls";
        string TempFile = "../../../system/temp/rpt_employee_detail_list_" + DateTime.Now.ToString("hhmmss") +Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        string SQL
        = "  SELECT '', " +
        "         TO_CHAR (SYSDATE, 'dd/mm/yyyy'), " +
        "         e.ORG_NM, " +
        "         c.org_nm AS team, " +
        "         d.workgroup_nm, " +
        "         a.emp_id, " +
        "         a.old_id, " +
        "         a.full_name, " +
        "         a.ID_NUM, " +
        "         a.birth_dt, " +
        "         (SELECT 	code_nm " +
        "            FROM vhr_hr_code " +
        "           WHERE id = 'HR0021' AND code = a.PLACE_BIRTH) " +
        "            place_birth, " +
        "         TO_CHAR (TO_DATE (join_dt, 'yyyymmdd'), 'dd/mm/yyyy') join_dt, " +
        "         (SELECT code_nm " +
        "            FROM vhr_hr_code " +
        "           WHERE id = 'HR0010' AND code = a.JOB_TYPE) " +
        "            job_type, " +
        "         (SELECT code_nm " +
        "            FROM vhr_hr_code " +
        "           WHERE id = 'HR0008' AND code = a.POS_TYPE) " +
        "            pos_type, " +
        "         NVL (a.pro_SAL, 0), " +
        "         NVL(a.BASIC_SAL,0), " +
        "         NVL(a.ALLOW_AMT1,0), " +
        "         NVL(a.ALLOW_AMT2,0), " +
        "         NVL(a.ALLOW_AMT3,0), " +
        "         NVL(a.ALLOW_AMT4,0), " +
        "         NVL(a.ALLOW_AMT5,0), " +
        "         NVL(a.ALLOW_AMT6,0), " +
        "         NVL(a.ALLOW_AMT7,0), " +
        "         NVL(a.ALLOW_AMT8,0), " +
        "         a.TEL, " +
        "         a.PERMANENT_ADDR, " +
        "         a.PRESENT_ADDR, " +
        "         (SELECT code_nm " +
        "            FROM vhr_hr_code " +
        "           WHERE id = 'HR0007' AND code = a.SEX), " +
        "         a.PERSON_ID, " +
        "         TO_CHAR (TO_DATE (a.ISSUE_DT, 'yyyymmdd'), 'dd/mm/yyyy'), " +
        "         (SELECT code_nm " +
        "            FROM vhr_hr_code " +
        "           WHERE id = 'HR0014' AND code = a.PLACE_PER_ID) place_person, " +
        "         DECODE (MARRIED_YN, 'Y', 'Married', 'Single') married, " +
        "         (SELECT code_nm " +
        "            FROM vhr_hr_code " +
        "           WHERE id = 'HR0009' AND code = a.Nation) nation, " +
        "         (SELECT code_nm " +
        "            FROM vhr_hr_code " +
        "           WHERE id = 'HR0015' AND code = a.ETHNIC_TYPE) ethnic_type, " +
        "         (SELECT code_nm " +
        "            FROM vhr_hr_code " +
        "           WHERE id = 'HR0016' AND code = a.RELIG_TYPE) relig_type, " +
        "         (SELECT code_nm " +
        "            FROM vhr_hr_code " +
        "           WHERE id = 'HR0011' AND code = a.EDU_TYPE) edu_type, " +
        "         (SELECT code_nm " +
        "            FROM vhr_hr_code " +
        "           WHERE id = 'HR0002' AND code = a.PROB_TYPE) prob_type, " +
        "         a.BEGIN_PROBATION begin_prob, " +
        "         a.END_PROBATION end_prob, " +
        "         (SELECT code_nm " +
        "            FROM vhr_hr_code " +
        "           WHERE id = 'HR0001' AND code = a.CONTRACT_TYPE) contract_type, " +
        "         a.contract_no, " +
        "         a.BEGIN_Contract begin_contract, " +
        "         a.END_contract end_contract, " +
        "         DECODE (a.SOCIAL_YN, 'Y', 'Yes', 'No') social_yn, " +
        "         a.social_no, " +
        "         (SELECT code_nm " +
        "            FROM vhr_hr_code " +
        "           WHERE id = 'HR0013' AND code = a.SOCIAL_PLACE) social_place, " +
        "         TO_CHAR (TO_DATE (a.SOCIAL_DT, 'yyyymm'), 'mm/yyyy') social_dt, " +
        "         DECODE (a.Health_YN, 'Y', 'Yes', 'No') health_yn, " +
        "         a.health_no, " +
        "         (SELECT code_nm " +
        "            FROM vhr_hr_code " +
        "           WHERE id = 'HR0012' AND code = a.health_PLACE) health_place, " +
        "         TO_CHAR (TO_DATE (a.health_DT, 'yyyymm'), 'mm/yyyy') health_dt, " +
        "         (SELECT code_nm " +
        "            FROM vhr_hr_code " +
        "           WHERE id = 'HR0017' AND code = a.EMPLOYEE_TYPE) emp_type, " +
        "         (SELECT code_nm " +
        "            FROM vhr_hr_code " +
        "           WHERE id = 'HR0022' AND code = a.status) status, " +
        "         TO_CHAR (TO_DATE (a.left_dt, 'yyyymmdd'), 'dd/mm/yyyy') left_dt, " +
        "         (SELECT code_nm " +
        "            FROM vhr_hr_code " +
        "           WHERE id = 'HR0092' AND code = a.COST_GROUP) cost_group, " +
        "         (SELECT code_nm " +
        "            FROM vhr_hr_code " +
        "           WHERE id = 'HR0093' AND code = a.COST_KIND) cost_kind, " +
        "         pl.pl_nm, " +
        "         a.account, " +
        "         a.pit_tax_no, " +
        "         a.email, " +
        "         a.office_number, " +
        "         (select V.CODE_NM from vhr_hr_code v where v.id='HR0021' and v.code=a.native_country) native_country ,A.INSURANCE_SAL, " +
		"		 (select V.CODE_NM from vhr_hr_code v where v.id='HR0221' and v.code=a.blood) as blood_kind, "+
		"		 a.HEIGHT , "+
		"		 a.WEIGHT , "+
		"		 (select V.CODE_NM from vhr_hr_code v where v.id='HR0109' and v.code=a.blood) as group_grade, "+
		"		 (select V.CODE_NM from vhr_hr_code v where v.id='HR0110' and v.code=a.blood) as grade, "+
		"		 a.GRADE_TITLE	"+
        "    FROM thr_employee a, " +
        "         tco_org c, " +
        "         thr_work_group d,tco_org e, " +
        "         (SELECT e.pk AS pk, D.PL_NM || ' - ' || B.PLC_NM AS pl_nm " +
        "            FROM TAC_ABPL D, TAC_ABPLCENTER E, TAC_ABCENTER B " +
        "           WHERE     D.DEL_IF = 0 " +
        "                 AND E.DEL_IF = 0 " +
        "                 AND E.TAC_ABPL_PK = D.PK " +
        "                 AND E.TAC_ABCENTER_PK = B.PK) pl " +
        "   WHERE     a.del_if = 0 " +
        "         AND c.del_if = 0 " +
        "         AND d.del_if = 0 and e.del_if = 0 " +
        "         AND a.tco_org_pk = c.pk and c.p_pk = e.pk " +
        "         AND a.thr_wg_pk = d.pk " +
        "         AND pl.pk(+) = a.TAC_ABPL_PK " +
        "and decode('" + p_nation + "','ALL','ALL',a.NATION )='" + p_nation + "'"+
        "and (case when '" + p_search_by + "'='1' then upper(a.FULL_NAME) "+
        "           when '" + p_search_by + "'='2' then upper(a.emp_id) "+
        "           when '" + p_search_by + "'='3' then upper(a.id_num) "+
        "           when '" + p_search_by + "'='4' then upper(a.PERSON_ID ) "+
        "           when '" + p_search_by + "'='5' then upper(a.OLD_ID ) end) like  '%' || upper('" + p_search_temp + "') || '%'  "+
        "and (('" + p_from_joindate + "' is null and '" + p_to_joindate + "' is null)  "+
        "         or (a.JOIN_DT between '" + p_from_joindate + "' and '" + p_to_joindate + "') ) "+
        "and decode('" + p_salary_yn + "','ALL','ALL',a.SALARY_YN )='" + p_salary_yn + "'"+
        "and decode('" + p_position + "','ALL','ALL',a.POS_TYPE )='" + p_position + "'"+
        "and decode('" + p_pay_type + "','ALL','ALL',a.PAY_TYPE )='" + p_pay_type + "'"+
        "and decode('" + p_contract_kind + "','ALL','ALL',a.CONTRACT_TYPE )='" + p_contract_kind + "'"+
        "and (('" + p_from_contract + "' is null and '" + p_to_contract + "' is null)  "+
        "    or (a.BEGIN_CONTRACT between '" + p_from_contract + "' and '" + p_to_contract + "') ) "+
        "and decode('" + p_sex + "','ALL','ALL',a.SEX )='" + p_sex + "' "+
        "and decode('" + p_insurance_yn + "','ALL','ALL',a.SOCIAL_YN )='" + p_insurance_yn + "'"+
        "and decode('" + p_status + "','ALL','ALL',a.status)='" + p_status + "'"+
        "and (('" + p_from_leftdate + "' is null and '" + p_to_leftdate + "' is null)  "+
        "    or (a.LEFT_DT between '" + p_from_leftdate + "' and '" + p_to_leftdate + "') ) "+
        " and (('" + p_from_birthdate + "' is null and '" + p_to_birthdate + "' is null)  "+
        "    or (decode(length(a.BIRTH_DT),4,a.birth_dt || '0101',a.birth_dt) between '" + p_from_birthdate + "' and '" + p_to_birthdate + "') ) "+
        "and decode('" + p_ot_yn + "','ALL','ALL',a.ot_yn)='" + p_ot_yn + "'"+
        "and decode('" + p_thr_group_pk + "','ALL','ALL',d.pk)='" + p_thr_group_pk + "'"+
        "and decode('" + p_union + "','ALL','ALL',a.union_yn)='" + p_union + "'"+
        "AND (   a.tco_org_pk IN ( "+
        "                         SELECT     g.pk "+
        "                               FROM tco_org g "+
        "                              WHERE g.del_if = 0 "+
        "                         START WITH g.pk = "+
        "                                       DECODE ('" + p_tco_dept_pk + "', "+
        "                                               'ALL', 0, "+
        "                                               '" + p_tco_dept_pk + "'"+
        "                                              ) "+
        "                         CONNECT BY PRIOR g.pk = g.p_pk) "+
        "                   OR '" + p_tco_dept_pk + "' = 'ALL') "+
        "and decode('" + p_job + "','ALL','ALL',A.JOB_TYPE)='" + p_job + "'"+
        "and decode('" + p_education + "','ALL','ALL',A.EDU_TYPE)='" + p_education + "'"+
        "and ('" + p_birth_month + "'= 'ALL' or (LENGTH(A.BIRTH_DT)=8 and substr(A.BIRTH_DT,5,2)= '" + p_birth_month + "')) "+
        "   ORDER BY NVL (c.seq, 99999), " +
        "         org_nm, " +
        "         team, " +
        "         emp_id ";


        //Response.Write(SQL);
        //Response.End();

        DataTable dt_emp = ESysLib.TableReadOpen(SQL);
        int irow,icol_emp;
        irow = dt_emp.Rows.Count;
        icol_emp = dt_emp.Columns.Count;
        if (irow == 0)
        {
            Response.Write("There is no data");
            Response.End();
        }    

        
        DataTable dt_allow = ESysLib.TableReadOpenCursor("hr_rpt_allowance_salary");

        //DataTable dt_allow_k = ESysLib.TableReadOpenCursor("hr.sp_rpt_allowance_k_salary");

        int i, j, k, i_allow;
        int pos = 7, total_col = icol_emp;
        int allow = 16;     //vi tri phu cap
        
        //bind data to excel file
        //-----header---   

        exSheet.Cells["C2"].Value = Session["User_ID"].ToString();
        exSheet.Cells["C3"].Value = dt_emp.Rows[0][1].ToString();
        
        for (i_allow = 0; i_allow < 8; i_allow++)
        {
            if (dt_allow.Rows[0][i_allow + 8].ToString() == "1")
            {
                exSheet.Cells[5, allow + i_allow].Value = dt_allow.Rows[0][16 + i_allow].ToString() ;
                exSheet.Cells[6, allow + i_allow].Value = dt_allow.Rows[0][i_allow].ToString();
            }
        }


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
            for (j = 2; j < icol_emp; j++)
                if (j >= 14 && j <= 23)
                    exSheet.Cells[pos + i, j].Value = Double.Parse(dt_emp.Rows[i][j].ToString());
                else if (j == 37 || j == 38 || j == 41 || j == 42 || j == 9)
                {
                    if (dt_emp.Rows[i][j].ToString().Length == 8)
                        exSheet.Cells[pos + i, j].Value = new DateTime(int.Parse(dt_emp.Rows[i][j].ToString().Substring(0, 4)), int.Parse(dt_emp.Rows[i][j].ToString().Substring(4, 2)), int.Parse(dt_emp.Rows[i][j].ToString().Substring(6, 2)));

                    else
                        exSheet.Cells[pos + i, j].Value = dt_emp.Rows[i][j].ToString();
                }
				
                else
                    exSheet.Cells[pos + i, j].Value = dt_emp.Rows[i][j].ToString();
           
        }

        //Hide allowance column
        for (i_allow = 0; i_allow < 8; i_allow++)
        {
            if (dt_allow.Rows[0][i_allow + 8].ToString() != "1")
                exSheet.Range[1, allow + i_allow].Columns.Hidden = true;
        }

        //delete theo security

        if (p_sal_security == "N")
        {
            for (i = 0; i < 10; i++)
                exSheet.Range[1, allow - 2].Columns.EntireColumn.Delete();
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