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

public partial class rpt_atm_save_company : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {        
        ESysLib.SetUser(Session["APP_DBUSER"].ToString());

        string p_dept, p_group, p_status, p_type, p_bank_type, p_emp_id, p_work_mon, p_m_type,p_sal_period;


		p_dept = Request["l_dept"].ToString();
		p_group = Request["l_group"].ToString();
		p_status = Request["l_status"].ToString();
		p_type = Request["l_type"].ToString();
		p_bank_type = Request["l_pay_type"].ToString();
		p_emp_id = Request["l_emp_id"].ToString();
		p_work_mon = Request["l_work_mon"].ToString();
		p_m_type = Request.QueryString["l_m_type"].ToString();
		p_sal_period = Request["l_sal_period"].ToString();

		if (p_type == "ALL")
			p_type = "=nvl(s.net_amt,0)";
		
		DateTime p_month_dt=new DateTime(int.Parse(p_work_mon.Substring(0,4).ToString()),int.Parse(p_work_mon.Substring(4,2).ToString()),1) ;

        string TemplateFile = "rpt_atm_save_company.xls";
        string TempFile = "../../../system/temp/rpt_atm_save_company_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

         //Create a new workbook
		IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

		//Add worksheet
		IWorksheet exSheet = exBook.Worksheets[1];
		IRange range;

				
		string SQL =" SELECT a.dept_nm as a0,A.EMP_ID AS a1 "+			 
			 "    , initcap(a.FULL_NAME) AS a2  "+
			 "    ,null as a3 " +
			 "    , a.account AS a4     "+
			 "    , ROUND(nvl(a.NET_amt,0),3) AS a5 "+
			 "    ,null as a6 "+	
			 "    , ROUND(nvl(a.NET_amt,0),3) AS a7 "+			
				" from thr_month_salary a,thr_employee b " +
        "where a.del_if=0 AND B.DEL_IF=0 AND A.THR_EMP_PK=B.PK and a.work_mon='" + p_work_mon + "' and A.pay_type='02' " +
        " and (a.tco_dept_pk in ( " +
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
        " and decode('" + p_group + "','ALL','ALL',a.thr_group_pk)='" + p_group + "'" +
        " and a.emp_id like '%" + p_emp_id + "%' " + 
        " and decode('" + p_status + "','ALL','ALL',a.status)='" + p_status + "'" +
        " and (a.bank_type in(select H.CODE from vhr_hr_code h where h.id='HR0020' AND H.NUM_1='" + p_bank_type + "')" +
        "      OR '" + p_bank_type + "'='ALL') " +
        " and decode('" + p_m_type + "','ALL','ALL',a.money_kind)='" + p_m_type + "'" +
        " and decode('" + p_sal_period + "','ALL','ALL',a.sal_period)='" + p_sal_period + "'" +
        " and nvl(a.net_amt,0) " + p_type  + 
        "order by a.dept_nm,a.thr_group_nm,a.emp_id";
						
		//Response.Write(SQL);
		//Response.End();
		DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
		int irow_emp,icol_emp;
		irow_emp = dt_Emp.Rows.Count;
		icol_emp=dt_Emp.Columns.Count;
		
		if (irow_emp == 0)
		{
			Response.Write("There is no data of salary");
			Response.End();
		}
					
		// -------------
		string SQL_Com =" SELECT max(to_char(to_date('" + p_work_mon + "','yyyymm'),'mm/yyyy')) as a0 "+			 			
				" from dual " ;
        	
		DataTable dt_Com = ESysLib.TableReadOpen(SQL_Com);
		//int irow_dept,icol_dept;
		//irow_dept = dt_Dept.Rows.Count;
		//icol_dept=dt_Dept.Columns.Count;
		//------------------------------------------------------
		
		exSheet.Cells["A2"].Value = "Month " + dt_Com.Rows[0][0].ToString();
		
		//Insert new row
		
		int i=0;
		int pos_row=5;
		
		int irow_dept=0;
		
		string cur_dept="",old_dept="";
		int dept_count=0;	
		
		old_dept=dt_Emp.Rows[0][0].ToString() ;
        for (i = 0; i < irow_emp-1; i++)
        {
			cur_dept=dt_Emp.Rows[i][0].ToString();
			if(cur_dept!=old_dept)
			{
				exSheet.Range[pos_row + i +1 +dept_count, 1].Rows.EntireRow.Insert();	
				dept_count=dept_count+1;
				exSheet.Range[pos_row + i +1 +dept_count, 1].Rows.EntireRow.Insert();
				old_dept=cur_dept;
			}
			else
			{
				exSheet.Range[pos_row + i + 1+ dept_count, 1].Rows.EntireRow.Insert();			
			}            
        }
		
		irow_dept=dept_count +1;
		//show data
		
		//khai bao bien 
		
		
		cur_dept="";
		old_dept="";
		dept_count=0;		
		double[] Grant_Total=new double[3];
		double[] Sub_Total=new double[3];
		
		for (int j=5;j<icol_emp;j++)  
		{
			Grant_Total[j-5]=0;
			Sub_Total[j-5]=0;
		}
		
		int emp_count=0;
		int sub_e_count=0;
		
		old_dept=dt_Emp.Rows[0][0].ToString() ;
		for (i=0;i<irow_emp;i++)
		{
			cur_dept=dt_Emp.Rows[i][0].ToString();
												
			if(cur_dept!=old_dept)
			{						
				exSheet.Range[pos_row + irow_emp -2 + irow_dept+1, 1, pos_row +irow_emp -2+ irow_dept + 1, 50].Copy(exSheet.Range[pos_row +i+dept_count, 1, pos_row +i+dept_count, 50], XlPasteType.xlPasteAll);
				exSheet.Cells[pos_row +i+dept_count, 1].Value = old_dept;
				exSheet.Cells[pos_row +i+dept_count, 4].Value = emp_count;
				for(int j=5;j<icol_emp;j++)
				{
					if(j!=6)
					{
						exSheet.Cells[pos_row +i+dept_count, j+1].Value = Grant_Total[j-5];
					}
				}	
				for (int j=5;j<icol_emp;j++)  
				{
					Sub_Total[j-5]+=Grant_Total[j-5];
				}
				sub_e_count+=emp_count;
				for (int j=5;j<icol_emp;j++)  
				{
					Grant_Total[j-5]=0;
				}
				emp_count=0;
				// tinh sub total
				for (int j=5;j<icol_emp;j++)
				{
					if(IsNumeric(dt_Emp.Rows[i][j].ToString()))
					{
						Grant_Total[j-5]+=Double.Parse(dt_Emp.Rows[i][j].ToString());
					}
				}
				emp_count++;
				dept_count=dept_count+1;
				exSheet.Cells[pos_row + i+dept_count, 1].Value = i + 1;	
																		
				// insert data emp	
				exSheet.Cells[pos_row +i+dept_count, 3, pos_row +i+dept_count, 4].Merge();
																
				for (int j=1;j<icol_emp;j++)
				{				
					if(j<=4)
					{
						exSheet.Cells[pos_row +i+dept_count, j+1].Value = dt_Emp.Rows[i][j].ToString();
					}
					if(j>4)
					{
						if (IsNumeric(dt_Emp.Rows[i][j].ToString()))
						{
							exSheet.Cells[pos_row +i+dept_count, j+1].Value = double.Parse(dt_Emp.Rows[i][j].ToString());
						}
					}
				} 
				
				old_dept=cur_dept;
			}
			else
			{
				// tinh sub total
				for (int j=5;j<icol_emp;j++)
				{
					if(j!=6)
					{
						if(IsNumeric(dt_Emp.Rows[i][j].ToString()))
						{
							Grant_Total[j-5]+=Double.Parse(dt_Emp.Rows[i][j].ToString());
						}
					}
				}				
				emp_count++;				
				exSheet.Cells[pos_row + i+dept_count, 1].Value = i + 1;
				// insert data emp
				exSheet.Cells[pos_row +i+dept_count, 3, pos_row +i+dept_count, 4].Merge();
				for (int j=1;j<icol_emp;j++)
				{				
					if(j<=4)
					{
						exSheet.Cells[pos_row +i+dept_count, j+1].Value = dt_Emp.Rows[i][j].ToString();
					}
					if(j>4)
					{
						if(IsNumeric(dt_Emp.Rows[i][j].ToString()))
						{
							exSheet.Cells[pos_row +i+dept_count, j+1].Value = double.Parse(dt_Emp.Rows[i][j].ToString());
						}
					}
				}	
			}
			
		}
		
		// dong cuoi cung
		exSheet.Cells[pos_row + irow_emp -2 + irow_dept+1, 1].Value = cur_dept;
		exSheet.Cells[pos_row + irow_emp -2 + irow_dept+1, 4].Value = emp_count;
		for(int j=5;j<icol_emp;j++)
		{
			if(j!=6)
			{
				exSheet.Cells[pos_row + irow_emp -2 + irow_dept+1, j+1].Value = Grant_Total[j-5];
			}
		}	
				
		// sub total
		exSheet.Cells[pos_row + irow_emp -2 + irow_dept+2, 3].Value = sub_e_count + emp_count;
		for(int j=5;j<icol_emp;j++)
		{
			if(j!=6)
			{
				exSheet.Cells[pos_row + irow_emp -2 + irow_dept+2, j+1].Value = Sub_Total[j-5] + Grant_Total[j-5];
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
	public static bool IsNumeric(string strNum)
    {
        try
        {
            double tmp = double.Parse(strNum);
            return true;
        }
        catch
        {
            return false;
        }
    }
}
