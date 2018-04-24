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

public partial class reports_ch_ae_rpt_test_employee : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {        
		

        ESysLib.SetUser("APP_DBUSER");	
		//p_p_union = Request["p_25"].ToString();
		//p_lstProject = Request["p_26"].ToString();
	   // p_wg = Request["p_27"].ToString();

        string TemplateFile = "rpt_test_employee.xlsx";
        string TempFile = "../../../system/temp/rpt_test_employee_" + Session["User_ID"].ToString() + ".xls";
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


       string SQL
	= "select e.emp_id,  " + 
        "       e.full_name,  " +
        "       nvl(e.level1_sal,0) level1_sal,  " +
        "       nvl(basic_sal,0) basic_sal,  " +
        "       to_char( to_date( e.join_dt, 'yyyymmdd' ), 'DD/MM/YYYY' ) join_dt  " +
        "from   thr_employee e  " +
        "where  e.del_if = 0 and e.tco_org_pk = 44  " ;


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

        int l_pos = 3;

       
        for (int i = 0; i < l_row - 1; i++)
        {
            exSheet.Range[l_pos + i + 1, l_col].Rows.EntireRow.Insert();//insert dong moi 
        }

        //exSheet.Cells["C2"].Value = p_user;
        //exSheet.Cells["C3"].Value = myDT.Rows[0][0].ToString();


        for (int i = 0; i < l_row; i++)
        {

            //exSheet.Cells[l_pos + i, 1].Value = i+1; //stt

            /*for (int j = 1; j < l_col; j++) 
            {

                if (j == 12 || j == 13)
                {

                    exSheet.Cells[l_pos + i, j + 1].Value = double.Parse(myDT.Rows[i][j].ToString());
                }
                else
                    exSheet.Cells[l_pos + i, j + 1].Value = myDT.Rows[i][j].ToString();

            }
           /**/
		   
		  /* exSheet.Cells["A" + (l_pos + i) ].Value = myDT.Rows[i]["emp_id"].ToString(); 
		   exSheet.Cells["B" + (l_pos + i) ].Value = myDT.Rows[i]["full_name"].ToString(); 
		   exSheet.Cells["C" + (l_pos + i) ].Value = double.Parse(myDT.Rows[i]["level1_sal"].ToString()); 
		   exSheet.Cells["D" + (l_pos + i) ].Value = double.Parse(myDT.Rows[i]["basic_sal"].ToString()); 
		   exSheet.Cells["E" + (l_pos + i) ].Value = myDT.Rows[i]["join_dt"].ToString(); /**/
			
			for (int j = 1; j < l_col; j++) 
				exSheet.Cells[l_pos + i, j + 1].Value = myDT.Rows[i][j].ToString();
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
}