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

public partial class rpt_employee_pic : System.Web.UI.Page
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

        string TemplateFile = "rpt_employee_pic.xls";
        string TempFile = "../../../system/temp/rpt_employee_pic_" + Session["User_ID"].ToString() + ".xls";
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
//      STT	Mã NV	Mã Cũ	Bộ phận	Nhóm	Họ và tên	Hình	Số thẻ	Ngày vào	Loại nhân viên	Dự án	Lương thử việc	Phụ Cấp độc hại	
        //Ngày sinh	Nơi sinh	Công việc	Chức vụ



        string SQL;
        SQL = " select to_char(sysdate,'dd/mm/yyyy') C0 ";
        SQL = SQL + ",a.emp_id C1,a.old_id C2,(SELECT   MAX(T.org_NM) ";
        SQL = SQL + " FROM tco_org t      ";
        SQL = SQL + "   WHERE t.del_if = 0      ";
        SQL = SQL + "   AND T.org_TYPE IN('06') ";
        SQL = SQL + "  START WITH t.pk=a.tco_org_pk ";
        SQL = SQL + "  CONNECT BY PRIOR t.p_pk=t.pk) AS C3 "; //1
        SQL = SQL + " ,c.org_nm C4,a.full_name C5 ";
        SQL = SQL + " ,d.data C6 ";
        SQL = SQL + " ,a.ID_NUM C7 ";
        SQL = SQL + ",to_char(to_date(join_dt,'yyyymmdd'),'dd/mm/yyyy') C8 ";
        SQL = SQL + ",nvl(a.PRO_SAL,0) C9 ";
        SQL = SQL + ",nvl(a.ALLOW_AMT1,0) C10 ";
        SQL = SQL + ",decode(length(birth_dt),4,birth_dt,to_char(to_date(BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy')) C11 ";
        SQL = SQL + ",(select code_nm from vhr_hr_code where id='HR0021' and code=a.PLACE_BIRTH) C12 ";
        SQL = SQL + ",(select code_nm from vhr_hr_code where id='HR0010' and code=a.JOB_TYPE) C13 ";
        SQL = SQL + ",(select code_nm from vhr_hr_code where id='HR0008' and code=a.POS_TYPE) C14, NVL(C.SEQ,99999999) C15 ";
        SQL = SQL + "from thr_employee a,thr_work_group b,tco_org c,TC_FSBINARY d ";
        SQL = SQL + "where a.del_if=0 and b.del_if=0 and c.del_if=0 and d.del_if(+)=0";
        SQL = SQL + "and a.thr_wg_pk=b.pk  and a.photo_pk=d.pk(+)";
        SQL = SQL + "and a.tco_org_pk=c.pk ";
        SQL = SQL + "and decode('" + p_thr_group_pk + "','ALL','ALL',b.pk)='" + p_thr_group_pk + "'";
        SQL = SQL + "and decode('" + p_nation + "','ALL','ALL',a.NATION )='" + p_nation + "'";
        SQL = SQL + "and (('" + p_search_by + "'='1' and upper(a.FULL_NAME) like  '%' || upper('" + p_search_temp + "') || '%') ";
        SQL = SQL + "         or ('" + p_search_by + "'='2' and upper(a.emp_id) like  '%' || upper('" + p_search_temp + "') || '%') ";
        SQL = SQL + "         or ('" + p_search_by + "'='3' and upper(a.id_num) like  '%' || upper('" + p_search_temp + "') || '%') ";
        SQL = SQL + "         or ('" + p_search_by + "'='4' and upper(a.PERSON_ID ) like  '%' || upper('" + p_search_temp + "') || '%') ";
        SQL = SQL + "         or ('" + p_search_by + "'='5' and upper(a.OLD_ID ) like  '%' || upper('" + p_search_temp + "') || '%')) ";
        SQL = SQL + "and (('" + p_from_joindate + "' is null and '" + p_to_joindate + "' is null)  ";
        SQL = SQL + "         or (a.JOIN_DT between '" + p_from_joindate + "' and '" + p_to_joindate + "') ) ";
        SQL = SQL + "and decode('" + p_salary_yn + "','ALL','ALL',a.SALARY_YN )='" + p_salary_yn + "'";
        SQL = SQL + "and decode('" + p_position + "','ALL','ALL',a.POS_TYPE )='" + p_position + "'";
        SQL = SQL + "and decode('" + p_pay_type + "','ALL','ALL',a.PAY_TYPE )='" + p_pay_type + "'";
        SQL = SQL + "and decode('" + p_contract_kind + "','ALL','ALL',a.CONTRACT_TYPE )='" + p_contract_kind + "'";
        SQL = SQL + "and (('" + p_from_contract + "' is null and '" + p_to_contract + "' is null)  ";
        SQL = SQL + "    or (a.BEGIN_CONTRACT between '" + p_from_contract + "' and '" + p_to_contract + "') ) ";
        SQL = SQL + "and decode('" + p_sex + "','ALL','ALL',a.SEX )='" + p_sex + "' ";
        SQL = SQL + "and decode('" + p_insurance_yn + "','ALL','ALL',a.SOCIAL_YN )='" + p_insurance_yn + "'";
        SQL = SQL + "and decode('" + p_status + "','ALL','ALL',a.status)='" + p_status + "'";
        SQL = SQL + "and (('" + p_from_leftdate + "' is null and '" + p_to_leftdate + "' is null)  ";
        SQL = SQL + "    or (a.LEFT_DT between '" + p_from_leftdate + "' and '" + p_to_leftdate + "') ) ";
        SQL = SQL + " and (('" + p_from_birthdate + "' is null and '" + p_to_birthdate + "' is null)  ";
        SQL = SQL + "    or (decode(length(a.BIRTH_DT),4,a.birth_dt || '0101',a.birth_dt) between '" + p_from_birthdate + "' and '" + p_to_birthdate + "') ) ";
        SQL = SQL + "and decode('" + p_ot_yn + "','ALL','ALL',a.ot_yn)='" + p_ot_yn + "'";
        SQL = SQL + " and decode('" + p_union + "','ALL','ALL',a.union_yn)='" + p_union + "'";
        SQL = SQL + "AND (   a.tco_org_pk IN ( ";
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
        SQL = SQL + "AND ('" + p_birth_month + "'= 'ALL' or (LENGTH(A.BIRTH_DT)=8 and substr(A.BIRTH_DT,5,2)= '" + p_birth_month + "')) ";
        SQL = SQL + "AND ('" + p_maternity_dt + "'= 'ALL' or ('" + p_maternity_dt + "' ='01' and a.maternity_leave_dt is not null) or ('" + p_maternity_dt + "' ='02' and a.maternity_leave_dt is null)) ";
        SQL = SQL + " ORDER BY nvl(c.seq,99999999),C3,C1 ";


        


		//Response.Write(SQL);
		//Response.End();
		
		myDT = ESysLib.TableReadOpen(SQL);

        if (myDT.Rows.Count <= 0)
        {
            Response.Write("There is no data !!!");
            Response.End();
        }


        int l_row = myDT.Rows.Count;
        int l_col = myDT.Columns.Count;

        int l_pos = 7;

       
        for (int i = 0; i < l_row - 1; i++)
        {

            exSheet.Range[l_pos + i + 1, l_col].Rows.EntireRow.Insert();//insert dong moi 
        }

        
        exSheet.Cells["C3"].Value = myDT.Rows[0][0].ToString();


        for (int i = 0; i < l_row; i++)
        {

            exSheet.Cells[l_pos + i, 1].Value = i+1; //stt

            for (int j = 1; j < l_col-1; j++) 
            {

                if (j == 6)
                {
                    if (!string.IsNullOrEmpty(myDT.Rows[i][j].ToString())) //xac dinh hublob co data hay ko
                    {
                        byte[] MyData = new byte[0];
                        MyData = (byte[])myDT.Rows[i][j];
                        MemoryStream stream = new MemoryStream(MyData);

                        Bitmap b = new Bitmap(stream);
                        exSheet.Cells[l_pos + i, j + 1].Select();
                        exSheet.Shapes.AddPicture(ResizeImage(b, 140, 100));
                    }
                }
                else if (j ==9 || j == 10)
                {

                    exSheet.Cells[l_pos + i, j + 1].Value = double.Parse(myDT.Rows[i][j].ToString());
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
