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

public partial class rpt_salary_adj_sample : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		string p_adj_type = Request["p_adj_type"].ToString();
		string file_name = Request["p_file_name"].ToString();
		
        string TempFile = file_name;
        string TemplateFile = "../../../system/temp/rpt_salary_adj_sample_" + Session["User_ID"].ToString() + ".xls";
        //TempFile = Server.MapPath(TempFile);
        //TemplateFile = Server.MapPath(TemplateFile);	
		
		//Create a new workbook
		IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TempFile);
		exBook.Worksheets.Add();

		//Add worksheet 
		IWorksheet exSheet = exBook.Worksheets[1];
		string para = string.Empty;
		int sRow = 3;
		int eRow = 1000; //default excel 65536
		int sCol = 1;
		int eCol = 20; //default excel 256
		int result = 0;

		List<string> myList = new List<string>();

		DataTable dt = exSheet.Cells[sRow, sCol, eRow, eCol].GetDataTable(false, false); // ColHeaders = true => sRow + 1
		for (int i = 0; i < dt.Rows.Count; i++)
		{
			if (!string.IsNullOrEmpty(dt.Rows[i][1].ToString()))
			{
				for (int j = 0; j < dt.Columns.Count; j++)
				{
					if (!string.IsNullOrEmpty(dt.Rows[i][j].ToString()))
					{
						myList.Add(dt.Rows[i][j].ToString());
					}
					else
						break;
				}
				
				myList.Add(p_adj_type);
				if (ESysLib.TableReadOpenObject("GENUWIN.HR_SP_IMP_EXCEL", "'" + string.Join("','", myList.ToArray()) + "'") == 1)
				{
					result++;
					myList.Clear();
				}
			}
			else
				break;
		}
		
		Response.Write("Imported : " + result + " row(s)");
		Response.End();
    }
}