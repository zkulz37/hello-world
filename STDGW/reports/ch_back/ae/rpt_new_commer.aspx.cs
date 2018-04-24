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
using System.Globalization;

public partial class rpt_new_commer : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {        
		

        ESysLib.SetUser("APP_DBUSER");


        string p_thr_group_pk, p_nation, p_search_by, p_search_temp, p_from_joindate, p_to_joindate;
        string p_salary_yn, p_position, p_pay_type, p_contract_kind, p_from_contract, p_to_contract;
        string p_sex, p_insurance_yn, p_status, p_from_leftdate, p_to_leftdate, p_from_birthdate;
        string p_ot_yn, p_to_birthdate, p_tco_org_pk, p_sal_security;
        string p_job, p_education, p_union, p_lstProject, p_wg, p_birth_month, p_maternity_dt;

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
        p_tco_org_pk = Request["p21"].ToString();
        p_sal_security = Request["p22"].ToString();
        p_job = Request["p23"].ToString();
        p_education = Request["p24"].ToString();
        p_union = Request["p25"].ToString();
        p_birth_month = Request["p26"].ToString();
        p_maternity_dt = Request["p27"].ToString();
		
		//p_p_union = Request["p_25"].ToString();
		//p_lstProject = Request["p_26"].ToString();
	   // p_wg = Request["p_27"].ToString();

        string TemplateFile = "rpt_new_commer.xls";
        string TempFile = "../../../system/temp/rpt_new_commer_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];
        IRange range;

        /*int l_temp, loop_row, loop_col;
        l_temp   = 0;
        loop_row = 41;
        loop_col = 7;*/

        DataTable myDT = new DataTable();

        string SQL
    = "SELECT TO_CHAR(SYSDATE,'DD-MON-YYYY') C0,A.EMP_ID C1,A.FULL_NAME C2,B.ORG_NM C3 " +
        ",(SELECT V.CODE_NM FROM VHR_HR_CODE V WHERE V.ID='HR0008' AND V.CODE=A.POS_TYPE) C4 " +
        ",A.JOIN_DT C5 " +
        ",(CASE WHEN LENGTH(A.BIRTH_DT)=4 THEN A.BIRTH_DT||'0101' ELSE A.BIRTH_DT END) c6 "+
        ",A.PERSON_ID C7 " +
        ",(CASE WHEN LENGTH(A.ISSUE_DT)=4 THEN A.ISSUE_DT||'0101' ELSE A.ISSUE_DT END) C8 " +
        ",A.PERMANENT_ADDR C9 " +
        "FROM THR_EMPLOYEE A,TCO_ORG B " +
        "WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND A.TCO_ORG_PK=B.PK ";
        SQL = SQL + " and decode('" + p_thr_group_pk + "','ALL','ALL',b.pk)='" + p_thr_group_pk + "'";
        SQL = SQL + " and decode('" + p_nation + "','ALL','ALL',a.NATION )='" + p_nation + "'";
        SQL = SQL + " and (('" + p_search_by + "'='1' and upper(a.FULL_NAME) like  '%' || upper('" + p_search_temp + "') || '%') ";
        SQL = SQL + "         or ('" + p_search_by + "'='2' and upper(a.emp_id) like  '%' || upper('" + p_search_temp + "') || '%') ";
        SQL = SQL + "         or ('" + p_search_by + "'='3' and upper(a.id_num) like  '%' || upper('" + p_search_temp + "') || '%') ";
        SQL = SQL + "         or ('" + p_search_by + "'='4' and upper(a.PERSON_ID ) like  '%' || upper('" + p_search_temp + "') || '%') ";
        SQL = SQL + "         or ('" + p_search_by + "'='5' and upper(a.OLD_ID ) like  '%' || upper('" + p_search_temp + "') || '%')) ";
        SQL = SQL + " and a.JOIN_DT between '" + p_from_joindate + "' and '" + p_to_joindate + "' ";
        SQL = SQL + " and decode('" + p_salary_yn + "','ALL','ALL',a.SALARY_YN )='" + p_salary_yn + "'";
        SQL = SQL + " and decode('" + p_position + "','ALL','ALL',a.POS_TYPE )='" + p_position + "'";
        SQL = SQL + " and decode('" + p_pay_type + "','ALL','ALL',a.PAY_TYPE )='" + p_pay_type + "'";
        SQL = SQL + " and decode('" + p_contract_kind + "','ALL','ALL',a.CONTRACT_TYPE )='" + p_contract_kind + "'";
        SQL = SQL + " and (('" + p_from_contract + "' is null and '" + p_to_contract + "' is null)  ";
        SQL = SQL + "    or (a.BEGIN_CONTRACT between '" + p_from_contract + "' and '" + p_to_contract + "') ) ";
        SQL = SQL + " and decode('" + p_sex + "','ALL','ALL',a.SEX )='" + p_sex + "' ";
        SQL = SQL + " and decode('" + p_insurance_yn + "','ALL','ALL',a.SOCIAL_YN )='" + p_insurance_yn + "'";
        SQL = SQL + " and decode('" + p_status + "','ALL','ALL',a.status)='" + p_status + "'";
        SQL = SQL + " and (('" + p_from_leftdate + "' is null and '" + p_to_leftdate + "' is null)  ";
        SQL = SQL + "    or (a.LEFT_DT between '" + p_from_leftdate + "' and '" + p_to_leftdate + "') ) ";
        SQL = SQL + " and (('" + p_from_birthdate + "' is null and '" + p_to_birthdate + "' is null)  ";
        SQL = SQL + "    or (decode(length(a.BIRTH_DT),4,a.birth_dt || '0101',a.birth_dt) between '" + p_from_birthdate + "' and '" + p_to_birthdate + "') ) ";
        SQL = SQL + " and decode('" + p_ot_yn + "','ALL','ALL',a.ot_yn)='" + p_ot_yn + "'";
        SQL = SQL + " and decode('" + p_union + "','ALL','ALL',a.union_yn)='" + p_union + "'";
        SQL = SQL + " AND (   a.tco_org_pk IN ( ";
        SQL = SQL + "                         SELECT     g.pk ";
        SQL = SQL + "                               FROM tco_org g ";
        SQL = SQL + "                              WHERE g.del_if = 0 ";
        SQL = SQL + "                         START WITH g.pk = ";
        SQL = SQL + "                                       DECODE ('" + p_tco_org_pk + "', ";
        SQL = SQL + "                                               'ALL', 0, ";
        SQL = SQL + "                                               '" + p_tco_org_pk + "'";
        SQL = SQL + "                                              ) ";
        SQL = SQL + "                         CONNECT BY PRIOR g.pk = g.p_pk) ";
        SQL = SQL + "                   OR '" + p_tco_org_pk + "' = 'ALL') ";
        SQL = SQL + " AND ('" + p_birth_month + "'= 'ALL' or (LENGTH(A.BIRTH_DT)=8 and substr(A.BIRTH_DT,5,2)= '" + p_birth_month + "')) ";
        SQL = SQL + " ORDER BY a.emp_id ";

      

		//Response.Write(SQL);
	//	Response.End();
		
		myDT = ESysLib.TableReadOpen(SQL);

        if (myDT.Rows.Count <= 0)
        {
            Response.Write("There is no data !!!");
            Response.End();
        }


        int l_row = myDT.Rows.Count;
        int l_col = myDT.Columns.Count;

        int l_pos = 5;
        int y, m, d;

        DateTimeFormatInfo dtfi = CultureInfo.CreateSpecificCulture("en-US").DateTimeFormat;
       
        for (int i = 0; i < l_row - 1; i++)
        {

            exSheet.Range[l_pos + i + 1, l_col].Rows.EntireRow.Insert();//insert dong moi 
        }

       
        exSheet.Cells["A3"].Value = "UPDATE: "+myDT.Rows[0][0].ToString();


        for (int i = 0; i < l_row; i++)
        {

            exSheet.Cells[l_pos + i, 1].Value = i+1; //stt

            for (int j = 1; j < l_col; j++) 
            {
                if (j == 5 || j==6||j==8)
                {

                    exSheet.Cells[l_pos + i, j + 1].Value = new DateTime(int.Parse(myDT.Rows[i][j].ToString().Substring(0, 4)), int.Parse(myDT.Rows[i][j].ToString().Substring(4, 2)), int.Parse(myDT.Rows[i][j].ToString().Substring(6, 2)));
//DateTime dt = DateTime.ParseExact(myDT.Rows[i][j].ToString(), "yyyymmdd", CultureInfo.InvariantCulture);
                    //var date = DateTime.ParseExact("04/10/2012", "dd/MM/yyyy", CultureInfo.InvariantCulture);
                }
                else
                    exSheet.Cells[l_pos + i, j + 1].Value = myDT.Rows[i][j].ToString();

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
	
	public static Bitmap ResizeImage(Bitmap d, int w, int h)
	{
		Bitmap q = new Bitmap(w, h);
		float f, g;
		f = (float)w / (float)d.Width;
		g = (float)h / (float)d.Height;
		for (int i = 0; i < w; i++)
		{
			for (int j = 0; j < h; j++)
			{
				Color c;
				c = d.GetPixel((int)(i / f), (int)(j / g));
				q.SetPixel(i, j, c);
			}
		}
		return q;
	} 
}
