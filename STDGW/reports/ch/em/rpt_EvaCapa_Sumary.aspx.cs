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

public partial class rpt_EvaCapa_Sumary : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
	   string TemplateFile = "rpt_EvaCapa_Sumary.xls";
       string TempFile = "../../../system/temp/rpt_EvaCapa_Sumary_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);
		
		 //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
        IWorksheet exSheet = exBook.Worksheets[1];
	   
	 string p_Org_Code,p_Grp_Code,p_Searchby,p_Search,p_EvaMaster,p_Eva_Group,p_Status,p_lstManager,p_lstMan_Search_by,p_txtMsearchtmpDetail, p_txtNumOfLevel;	
	 
	 p_Org_Code = Request["p_Org_Code"].ToString();
	 p_Grp_Code = Request["p_Grp_Code"].ToString();
	 p_Searchby = Request["p_Searchby"].ToString();
	 p_Search = Request["p_Search"].ToString();
	 p_EvaMaster = Request["p_EvaMaster"].ToString();
	 p_Eva_Group = Request["p_Eva_Group"].ToString();
	 p_Status =  Request["p_Status"].ToString();
	 p_lstManager =  Request["p_lstManager"].ToString();
	 p_lstMan_Search_by =  Request["p_lstMan_Search_by"].ToString();
	 p_txtMsearchtmpDetail =  Request["p_txtMsearchtmpDetail"].ToString();
	 p_txtNumOfLevel =  Request["p_txtNumOfLevel"].ToString();
	 
	 int irow_emp,icol_emp;
	
	string SQL
	=   "     select  " + 
        "      e.org_nm as org_nm, f.workgroup_nm, " +
        "       (select eva_yyyy ||'-'|| eva_seq from thr_eva_master ms where ms.pk = b.thr_eva_master_pk)  , " +
        "      ( select gp.group_nm from thr_eva_group_v2 gp  where gp.pk =   b.thr_eva_group_pk), " +
        "     a.emp_id,  a.full_name " +
        "     ,(select v.code_nm from vhr_hr_code v where v.id='HR0103' and v.code=b.eva_emp_status) eva_status " +
        "     ,b.m1_nm, " +
        "     (select v.code_nm from vhr_hr_code v where id='HR0102' and  v.code = b.l1_status) , " +
        "     b.l1_score,  b.m2_nm, " +
        "     (select v.code_nm from vhr_hr_code v where id='HR0102' and  v.code = b.l2_status) , " +
        "     b.l2_score,b.m3_nm, " +
        "     (select v.code_nm from vhr_hr_code v where id='HR0102' and  v.code = b.l3_status) , " +
        "     b.l3_score, b.final_score " +
       // "     ,b.thr_eva_emp_pk " +
        "  from  thr_employee a, " +
        " ( select   a.thr_eva_emp_pk ,a.thr_emp_pk ,a.factor_type " +
        "             ,a.thr_eva_master_pk , a.thr_eva_group_pk , a.m1_id,a.m1_nm,a.m2_id " +
        "             ,a.m2_nm,a.m3_id,a.m3_nm ,a.l1_status ,a.l2_status,a.l3_status " +
        "              ,b.l1_score , b.l2_score ,b.l3_score  ,b.final_score,a.eva_emp_status " +
        "    from  " +
        "    ( select  a.pk as thr_eva_emp_pk ,a.thr_emp_pk ,c.factor_type ,a.thr_eva_master_pk " +
        "              ,c.thr_eva_group_pk ,a.eva_emp_status " +
        "              ,(select e.emp_id from thr_employee e where e.del_if=0 and e.pk=a.manager_l1_pk) m1_id " +
        "              ,(select e.emp_id||'-'|| e.full_name from thr_employee e where e.del_if=0 and e.pk=a.manager_l1_pk) m1_nm " +
        "              ,(select e.emp_id  from thr_employee e where e.del_if=0 and e.pk=a.manager_l2_pk) m2_id " +
        "              ,(select e.emp_id||'-'|| e.full_name  from thr_employee e where e.del_if=0 and e.pk=a.manager_l2_pk) m2_nm   " +
        "              ,(select e. emp_id  from thr_employee e where e.del_if=0 and e.pk=a.manager_l3_pk) m3_id " +
        "              ,(select e. emp_id||'-'|| e.full_name from thr_employee e where e.del_if=0 and e.pk=a.manager_l3_pk) m3_nm   " +
		"			   ,max(d.l1_status)l1_status ,max(d. l2_status)l2_status,max(d. l3_status)l3_status	" +
        "          from thr_eva_emp_v2 a , thr_eva_group_v2 b, " +
        "          (select g.thr_eva_group_pk,g.factor_type " +
        "            from  thr_eva_factor_v2 g " +
        "            where g.del_if=0 and g.factor_type ='02' " +
        "            )c, " +
		"          (  select  a.thr_eva_emp_pk, a.factor_type " +
        "                       ,max(case when a.eva_level='1' then a.eva_status else null end) l1_status " +
        "                      ,max(case when a.eva_level='2' then a.eva_status else null end) l2_status " +
        "                      ,max(case when a.eva_level='3' then a.eva_status else null end) l3_status " +
        "               from thr_eva_status a " +
        "               where  a.del_if=0 and a.factor_type= '02' " +
        "                 group by  a.thr_eva_emp_pk, a.factor_type " +
        "           )d " +
        "   where a.del_if=0 and b.del_if=0  " +
        "               and a.thr_eva_group_pk=b.pk " +
        "                and c.thr_eva_group_pk=b.pk and  a.pk = d.thr_eva_emp_pk(+) " +
		
        "      group by a.pk,a.thr_emp_pk,c.factor_type,a.thr_eva_master_pk,a.eva_emp_status,c.thr_eva_group_pk,a.manager_l1_pk,a.manager_l2_pk,a.manager_l3_pk " +
        "       ) a,  " +
        "          (  select e.thr_eva_emp_pk  ,e.factor_type  " +
        "                        ,sum( e.l1_score) l1_score , sum(e.l2_score) l2_score ,sum(e.l3_score) l3_score " +
        "                           ,sum(e.final_score) final_score " +
        "             from thr_eva_score_v2 e " +    
        "         where e.del_if=0  and e.factor_type ='02' " +
        "         group by e.thr_eva_emp_pk,e.factor_type   " +
        "         )b " +
        "    where a.thr_eva_emp_pk = b.thr_eva_emp_pk(+) and " +
        "                 a.factor_type =  b.factor_type(+)    " +
        " ) b,  " +
        " tco_org e,thr_work_group f  " +
        " where a.del_if =0  and  e.del_if =0 and f.del_if = 0 " +
        " and  a.tco_org_pk=e.pk " +
        " and a.thr_wg_pk=f.pk " +
        " and a.pk = b.thr_emp_pk " +
        " and (case when '"+p_Grp_Code+"'='ALL' then '"+p_Grp_Code+"' else to_char(f.pk) end)='"+ p_Grp_Code+"'"+
        " and (   a.tco_org_pk in ( select   g.pk " +
        "                                    from tco_org g " +
        "                                   where g.del_if = 0 " +
        "                                 start with g.pk = (case when '"+ p_Org_Code +"'='ALL' then  g.pk else to_number( '"+p_Org_Code+"' ) end) " +
        "                                 connect by prior g.pk = g.p_pk) " +
        "     ) " +
        " and (case when '"+p_Searchby+"' = '1' then upper(a.emp_id)  " +
        "            when '"+p_Searchby+"' = '2' then upper(a.full_fname)             " +
        "              when '"+p_Searchby+"' = '3' then upper(a.id_num)  " +
        "           when '"+p_Searchby+"' = '4' then upper(a.person_id)  " +
        "            when '"+p_Searchby+"' = '5' then upper(a.old_id)  " +
        "             end ) like '%' || upper('"+p_Search+"')|| '%' " +
        " and (case when   '"+p_EvaMaster+"' ='ALL' then  '"+p_EvaMaster+"' else  to_char(b.thr_eva_master_pk)end) = '"+p_EvaMaster+"' " +
        " and (case when  '"+p_Eva_Group+"' ='ALL' then '"+p_Eva_Group+"' else to_char(b.thr_eva_group_pk) end) = '"+p_Eva_Group+"'" +
        " and nvl(b.eva_emp_status,'10')=(case when '"+p_Status+"'='ALL' then nvl(b.eva_emp_status,'10') else '"+p_Status+"' end) " +
        " and(case when '"+p_lstManager+"'='1'  " +
        "                 then (case when '"+p_lstMan_Search_by+"'='1' then upper(b.m1_id) " +
        "                            when '"+p_lstMan_Search_by+"'='2' then upper(b.m2_id) " +
        "                            else upper(b.m3_id) end) " +
        "            else (case when '"+p_lstMan_Search_by+"'='1' then upper(b.m1_nm) " +
        "                            when '"+p_lstMan_Search_by+"'='2' then upper(b.m2_nm) " +
        "                            else upper(b.m3_nm) end) " +
        "            end) like '%'||upper('"+p_txtMsearchtmpDetail+"')||'%' " +
        "                 order by   b.thr_eva_emp_pk DESC " ;

 
		;

	//	Response.Write(SQL);
     //   Response.End();
		
		
		DataTable dt_emp = ESysLib.TableReadOpen(SQL);	
		
       
		irow_emp = dt_emp.Rows.Count;
		icol_emp=dt_emp.Columns.Count;
		int spos = 7;
        if (dt_emp.Rows.Count == 0)
        {
            Response.Write("There is no data");
            Response.End();
        }				
		
		exSheet.Cells["C2"].Value = Session["User_ID"].ToString();
        exSheet.Cells["C3"].Value = DateTime.Today.ToString("dd/MM/yyyy");
		
		for (int i = 1; i < irow_emp; i++)
        {
            exSheet.Range[spos + i, 1].Rows.EntireRow.Insert();
        }
		
        for (int i = 0; i < irow_emp; i++)
        {					
			
            for (int j = 0; j < icol_emp; j++)
            {		         		
					if (j==9|| j==12||j==15||j==16 )
					{
						exSheet.Cells[spos+i, j +2].Value = dt_emp.Rows[i][j].ToString()!=""? double.Parse(dt_emp.Rows[i][j].ToString()):0;		
					}
					else
					{
						exSheet.Cells[spos+i, j +2].Value = dt_emp.Rows[i][j].ToString();			
					}
					
            }
			exSheet.Cells[spos+i, 1].Value = i+1;
        }
		
		for (int i_level = (8 + (int.Parse(p_txtNumOfLevel) * 3)); i_level < 17; i_level++)
        {
            exSheet.Range[1, i_level + 1].Columns.Hidden = true;
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