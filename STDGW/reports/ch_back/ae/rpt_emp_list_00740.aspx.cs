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

public partial class rpt_emp_list_00740 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {        
		

        ESysLib.SetUser("APP_DBUSER");


        string p_emp_pk = Request["emp_pk"].ToString();

		//p_p_union = Request["p_25"].ToString();
		//p_lstProject = Request["p_26"].ToString();
	   // p_wg = Request["p_27"].ToString();

        string TemplateFile = "rpt_emp_list_00740.xls";
        string TempFile = "../../../system/temp/rpt_emp_list_00740_" + Session["User_ID"].ToString() + ".xls";
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
       // STT	Mã NV	Mã Cũ	Bộ phận	Nhóm	Công việc	Chức vụ	Họ và tên	Số thẻ	Ngày sinh	Nơi sinh	Ngày vào	Lương T.V	Phụ Cấp độc hại	Địa chỉ thường trú	Địa chỉ tạm trú	
        //Giới tính	CMND	Ngày cấp	Nơi cấp	Trình trạng hôn nhân	Quốc tịch	Dân tộc	Tôn giáo	Học vấn	Loại thử việc	Ngày bắt đầu TV	Ngày kết thúc TV	
        //Loại hợp đồng	Số hợp đồng	Ngày HĐ	Ngày Hết HĐ	Tham gia BHXH	Số sổ BHXH	Nơi tham gia BHXH	Ngày tham gia BHXH	Tham gia BHYT	Số sổ BHYT	Nơi tham gia BHYT	
        //Ngày tham gia BHYT	Loại nhân viên	Trình trạng	Ngày nghỉ việc	Nghỉ thai sản	Nhóm Chi Phí	Loại Chi Phí	Phân bổ chính	Số TK	Mã số Thuế	Công đoàn	Ngày Tham Gia CĐ	Ngày Kết Thúc CĐ


        string SQL;
        SQL = " select to_char(sysdate,'dd/mm/yyyy') C0"; //0
        SQL = SQL + ",a.old_id C2,a.emp_id C1 ";
        SQL = SQL + " ,a.full_name C7,(SELECT   MAX(T.org_NM) ";
        SQL = SQL + " FROM tco_org t      ";
        SQL = SQL + "   WHERE t.del_if = 0      ";
        SQL = SQL + "   AND T.org_TYPE IN('06') ";
        SQL = SQL + "  START WITH t.pk=a.tco_org_pk ";
        SQL = SQL + "  CONNECT BY PRIOR t.p_pk=t.pk) AS C3 "; //1
        SQL = SQL + "  ,c.org_nm as C4 ";//2
         SQL = SQL + ",(select code_nm from vhr_hr_code where id='HR0010' and code=a.JOB_TYPE)  C5";//32
        SQL = SQL + ",(select code_nm from vhr_hr_code where id='HR0008' and code=a.POS_TYPE)  C6";//33
         SQL = SQL + ",a.ID_NUM C8  ";
        SQL = SQL + ", decode(length(birth_dt),4,birth_dt,to_char(to_date(BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy')) C9 ";
        SQL = SQL + ",(select code_nm from vhr_hr_code where id='HR0021' and code=a.PLACE_BIRTH) C10 ";
        SQL = SQL + ",to_char(to_date(a.join_dt,'yyyymmdd'),'dd/mm/yyyy') C11";
        SQL = SQL + ",nvl(a.pro_SAL,0) C12";//10
        SQL = SQL + ",nvl(a.ALLOW_AMT1,0)  C13";//11
        SQL = SQL + ",a.PERMANENT_ADDR C14,a.PRESENT_ADDR C15 ";//20 21 22
        SQL = SQL + ",(select code_nm from vhr_hr_code where id='HR0007' and code=a.SEX) C16 ";  //23
        SQL = SQL + ",a.PERSON_ID C17";//24
        SQL = SQL + ",to_char(to_date(a.ISSUE_DT,'yyyymmdd'),'dd/mm/yyyy') C18"; //25
        SQL = SQL + ",(select code_nm from vhr_hr_code where id='HR0014' and code=a.PLACE_PER_ID) C19"; //26
        SQL = SQL + ",decode(MARRIED_YN,'Y','Married','Single') C20"; //27
        SQL = SQL + ",(select code_nm from vhr_hr_code where id='HR0009' and code=a.Nation)  C21"; //28
        SQL = SQL + ",(select code_nm from vhr_hr_code where id='HR0015' and code=a.ETHNIC_TYPE ) C22"; //29
        SQL = SQL + ",(select code_nm from vhr_hr_code where id='HR0016' and code=a.RELIG_TYPE ) C23"; //30
        SQL = SQL + ",(select code_nm from vhr_hr_code where id='HR0011' and code=a.EDU_TYPE ) C24";//31
        SQL = SQL + ",(select code_nm from vhr_hr_code where id='HR0002' and code=a.PROB_TYPE ) C25";//34
        SQL = SQL + ",to_char(to_date(a.BEGIN_PROBATION ,'yyyymmdd'),'dd/mm/yyyy') C26";//35
        SQL = SQL + ",to_char(to_date(a.END_PROBATION ,'yyyymmdd'),'dd/mm/yyyy') C27";//36
        SQL = SQL + ",(select code_nm from vhr_hr_code where id='HR0001' and code=a.CONTRACT_TYPE  ) C28";//37
        SQL = SQL + ",a.contract_no C29";//38
        SQL = SQL + ",decode(a.contract_type,'01',to_char(to_date(HR_F_GET_CONTRACT_DT(a.end_probation),'yyyymmdd'),'dd/mm/yyyy') ,to_char(to_date(a.BEGIN_Contract ,'yyyymmdd'),'dd/mm/yyyy') ) C30";//39
        SQL = SQL + ",to_char(to_date(a.END_contract ,'yyyymmdd'),'dd/mm/yyyy') C31 ";//40
        SQL = SQL + ",decode(a.SOCIAL_YN,'Y','Yes','No') C32";//41
        SQL = SQL + ",a.social_no C33";//42
        SQL = SQL + ",(select code_nm from vhr_hr_code where id='HR0013' and code=a.SOCIAL_PLACE ) C34";//43
        SQL = SQL + ",to_char(to_date(a.SOCIAL_DT,'yyyymm'),'mm/yyyy') C35";//44
        SQL = SQL + ",decode(a.Health_YN,'Y','Yes','No')  C36";//45
        SQL = SQL + ",a.health_no C37";//46
        SQL = SQL + ",(select code_nm from vhr_hr_code where id='HR0012' and code=a.health_PLACE ) C38";//47
        SQL = SQL + ",to_char(to_date(a.health_DT,'yyyymm'),'mm/yyyy') C39";//48
        SQL = SQL + ",(select code_nm from vhr_hr_code where id='HR0017' and code=a.EMPLOYEE_TYPE ) C40";//49
        SQL = SQL + ",(select code_nm from vhr_hr_code where id='HR0022' and code=a.status ) C41";//50
        SQL = SQL + ",to_char(to_date(a.left_dt ,'yyyymmdd'),'dd/mm/yyyy') C42"; //51
        SQL = SQL + ",to_char(to_date(a.maternity_leave_dt ,'yyyymmdd'),'dd/mm/yyyy') C43 ";//52
        SQL = SQL + ",(select code_nm from vhr_hr_code where id='HR0004' and code=a.resign_type ) C44";//53
        SQL = SQL + ",(select code_nm from vhr_hr_code where id='HR0093' and code=a.COST_KIND ) C45";//54
        SQL = SQL + ", pl.pl_nm C46"; //55
        SQL = SQL + ", a.account C47,a.pit_tax_no C48";//56,57
        SQL = SQL + ",nvl(a.union_yn,'N') C49,to_char(to_date(A.UNION_FDT,'yyyymmdd'),'dd/mm/yyyy') C50,to_char(to_date(A.UNION_EDT,'yyyymmdd'),'dd/mm/yyyy') C51  ";  //58 59 60 61 62
        SQL = SQL + "from thr_employee a, tco_org c,thr_work_group d, THR_EMPLOYEE_RESIGN r ,";
        SQL = SQL + "(SELECT e.pk as pk,D.PL_NM||' - '||B.PLC_NM as pl_nm ";
        SQL = SQL + "                       FROM TAC_ABPL D, TAC_ABPLCENTER E, TAC_ABCENTER B ";
        SQL = SQL + "                        WHERE D.DEL_IF    = 0 ";
        SQL = SQL + "                          AND E.DEL_IF    = 0 ";
        SQL = SQL + "                          AND E.TAC_ABPL_PK = D.PK ";
        SQL = SQL + "                          AND E.TAC_ABCENTER_PK = B.PK) pl ";
        SQL = SQL + "where a.del_if=0   and c.del_if=0 and d.del_if=0 and r.del_if(+)=0 and r.thr_emp_pk(+)=a.pk ";
        SQL = SQL + "and a.tco_org_pk=c.pk and a.thr_wg_pk=d.pk and pl.pk(+)=a.TAC_ABPL_PK ";
        SQL = SQL + " and a.pk in (" + p_emp_pk + ") ";
        SQL = SQL + "  order by a.emp_id ";


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

        int l_pos = 7;

       
        for (int i = 0; i < l_row - 1; i++)
        {

            exSheet.Range[l_pos + i + 1, l_col].Rows.EntireRow.Insert();//insert dong moi 
        }

        //exSheet.Cells["C2"].Value = p_user;
        //exSheet.Cells["C3"].Value = myDT.Rows[0][0].ToString();


        for (int i = 0; i < l_row; i++)
        {

            exSheet.Cells[l_pos + i, 1].Value = i+1; //stt

            for (int j = 1; j < l_col; j++) 
            {

                if (j == 12 || j == 13)
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
