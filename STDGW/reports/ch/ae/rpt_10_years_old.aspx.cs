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

public partial class rpt_10_years_old : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {        
        ESysLib.SetUser(Session["APP_DBUSER"].ToString());

        string p_user, p_wg, p_search_by, p_search_temp, p_tco_org_pk, p_kind, p_to_regdate, p_from_regdate, p_to_regdate_text, p_from_regdate_text;
        string p_status, p_typeobj;
        p_user = Request["p_user"].ToString();
        p_wg = Request["p_wg"].ToString();
        p_search_by = Request["p_search_by"].ToString();
        p_search_temp = Request["p_search_temp"].ToString();
        p_tco_org_pk = Request["p_tco_org_pk"].ToString();
        p_kind = Request["p_kind"].ToString();
        p_from_regdate = Request["p_from_regdate"].ToString();
        p_to_regdate = Request["p_to_regdate"].ToString();
        p_from_regdate_text = Request["p_from_regdate_text"].ToString();
        p_to_regdate_text = Request["p_to_regdate_text"].ToString();
        p_status = Request["p_status"].ToString();
        p_typeobj = Request["p_typeobj"].ToString();

        DateTime p_month_dt = new DateTime(int.Parse(p_from_regdate.Substring(0, 4).ToString()), int.Parse(p_from_regdate.Substring(4, 2).ToString()), int.Parse(p_from_regdate.Substring(6, 2).ToString()));

        string TemplateFile = "rpt_10_years_old.xls";
        string TempFile = "../../../system/temp/rpt_10_years_old_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

         //Create a new workbook
		IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

		//Add worksheet
		IWorksheet exSheet = exBook.Worksheets[1];
		IRange range;
		DataTable myDT;
		string SQL = "";
		
		
		myDT = new DataTable();
       SQL
    = "select a.emp_id a0 " +
        ",a.full_name a1 " +
        ",b.org_nm a2 " +
        ",(select code_nm from vhr_hr_code v where v.id='HR0008' and v.code=a.pos_type) a3" +
        ",(select code_nm from vhr_hr_code v where v.id='HR0001' and v.code=a.contract_type) a4" +
        ",(select sum(nvl(e.child_no,1)) from thr_regulation e where e.del_if=0 and e.thr_emp_pk=t.thr_emp_pk and  e.kind IN ('02', '03') and TO_NUMBER(substr('" + p_from_regdate + "',1,4)) - TO_NUMBER(SUBSTR(e.START_DT,1,4))  >=0 and TO_NUMBER(substr('" + p_from_regdate + "',1,4))  - TO_NUMBER(SUBSTR(e.START_DT,1,4))  <=10) a5" + 
        ",TO_NUMBER(substr('" + p_from_regdate + "',1,4)) - TO_NUMBER(SUBSTR(T.START_DT,1,4)) a6" +
        ",to_char(to_date(t.START_DT,'yyyymmdd'),'dd/mm/yyyy') a7 " +
        ",decode(nvl(t.child_no,1),2,'sinh đôi',3,'sinh ba' ,'') a8" +
        " from thr_regulation t,thr_employee a,tco_org b,tco_org c " +
        "where t.del_if=0  and a.del_if=0 and b.del_if=0 and c.del_if=0  " +
        "and t.thr_emp_pk=a.pk and a.tco_org_pk=b.pk and b.p_pk=c.pk  " +
        "and  TO_NUMBER(substr('" + p_from_regdate + "',1,4)) - TO_NUMBER(SUBSTR(T.START_DT,1,4))  >=0 and TO_NUMBER(substr('" + p_from_regdate + "',1,4)) - TO_NUMBER(SUBSTR(T.START_DT,1,4)) <=10 " +
        " and t.kind in  ('02', '03') " +
        " AND decode('" + p_status + "','ALL','" + p_status + "',a.status)='" + p_status + "'" +
        "            AND DECODE ('" + p_wg + "', " +
        "                        'ALL', '" + p_wg + "', " +
        "                        a.thr_wg_pk " +
        "                       ) = '" + p_wg + "'" +
        "             AND UPPER (DECODE ('" + p_search_by + "', " +
        "                              1, a.full_name, " +
        "                              2, a.emp_id, " +
        "                              3,a.id_num, " +
        "                              4,person_id, " +
        "                              old_id) " +
        "                     ) LIKE '%' || UPPER ('" + p_search_temp + "') || '%' " +
        "            AND (  a.tco_org_pk IN ( " +
        "                              SELECT     g.pk " +
        "                                    FROM tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_tco_org_pk + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_tco_org_pk + "'" +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_tco_org_pk + "'= 'ALL') " +
        " order by b.org_nm,a.emp_id,t.start_dt ";

      //  Response.Write(SQL);
       // Response.End();
		myDT = ESysLib.TableReadOpen(SQL);
		
		int row = 9, col = 2;		
		if (myDT.Rows.Count == 0)
		{
			Response.Write("There is no data");
			Response.End();
		}
					
		int row_data = myDT.Rows.Count;
		int col_data = myDT.Columns.Count;




        exSheet.Cells["C5"].Value = p_month_dt.ToString("dd/MM/yyyy");
        double dtotal = 0;
        for (int i = 0; i < row_data; i++)
		{
            dtotal += double.Parse(myDT.Rows[i]["a5"].ToString());
            exSheet.Cells[row + i, 1].Value = i + 1;

            for (int j = 0; j < col_data; j++)
            {
                if (j==5 || j==6)
                    exSheet.Cells[row + i , j + col].Value = double.Parse(myDT.Rows[i][j].ToString());
                else
                    exSheet.Cells[row + i, j + col].Value = myDT.Rows[i][j].ToString();

            }
            
            if (i < row_data - 1)
			{
                exSheet.Range["A" + (row + i + 1) ].Rows.EntireRow.Insert();
			}
		}

        exSheet.Range[row + row_data, 7].Value = dtotal;
        exSheet.Range["H" + (row + row_data + 1)].Value = "Ngày " + p_month_dt.ToString("dd") + " tháng " + p_month_dt.ToString("MM") + " năm " + p_month_dt.ToString("yyyy");

		//exSheet.Cells["F" + (row)].Value = total;
		
		
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
