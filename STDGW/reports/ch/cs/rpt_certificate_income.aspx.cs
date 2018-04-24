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

public partial class rpt_certificate_income : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //ESysLib.SetUser("hr");
        ESysLib.SetUser(Session["APP_DBUSER"].ToString());

       string p_year,p_month_from,p_month_to,p_org,p_wg,p_emp_id;
     
  
    p_year       = Request["p_year"].ToString();
	p_org       = Request["p_org_pk"].ToString();
	p_wg       = Request["p_wg"].ToString();
	p_emp_id       = Request["p_emp_id"].ToString();
    p_month_from      = Request["p_month_from"].ToString();
    p_month_to      = Request["p_month_to"].ToString();
    
   string SQL
	= " " + 
        "  select E.FULL_NAME " +
        "  ,(select code_fnm from vhr_hr_code v where  v.id='HR0008' and V.CODE=e.pos_type ) " +
        "  ,E.PERSON_ID " +
        "  ,E.PIT_TAX_NO " +
        "  , case when HR_F_PERIOD_MONTH_2(E.JOIN_DT,E.SAL_PERIOD )<'"+p_month_from+"' then to_char(to_date('"+p_month_from+"'||'01','yyyymmdd'),'dd/mm/yyyy') " +
        "  else to_char(to_date(E.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy')  " +
        "  end  " +
        "  , case when HR_F_PERIOD_MONTH_2(nvl(e.left_dt,'30000101'),E.SAL_PERIOD )>'"+p_month_to+"' then to_char(last_day(to_date('"+p_month_to+"','yyyymm')),'dd/mm/yyyy') " +
        "  else to_char(to_date(e.left_dt,'yyyymmdd'),'dd/mm/yyyy')  " +
        "  end " +
        "  ,sum(round(nvl(S.INCOME_AMT_2,0),0)) " +
        "  ,sum(nvl(tax_payer_amt,0)) " +
        "  ,sum(nvl(family_depend_amt,0)) " +
        "  ,0 " +
        "  ,sum(round(nvl(S.SOCIAL_AMT,0),0)+round(nvl(S.HEALTH_AMT,0),0)+round(nvl(S.UNEMP_INS,0),0)) " +
        "  ,sum(round(nvl(s.income_tax,0)) ) " +
        "   " +
        "  from thr_month_salary s,thr_employee e where e.del_if=0 and e.pk=s.thr_emp_pk  " +
        "  and  s.del_if=0 and S.WORK_MON between '"+p_month_from+"' and '"+p_month_to+"'  " +
      	"  and decode('" + p_wg + "','ALL','" + p_wg + "',e.THR_WG_PK)='" + p_wg + "'  " +
		" and e.emp_id like upper('%"+p_emp_id +"%') "+
		"    and (e.TCO_org_PK in   (  " +
        "                              SELECT     g.pk  " +
        "                                    FROM tco_org g  " +
        "                                   WHERE g.del_if = 0  " +
        "                              START WITH g.pk =  " +
        "                                            DECODE ('" + p_org + "',  " +
        "                                                    'ALL', 0,  " +
        "                                                    '" + p_org + "'  " +
        "                                                   )  " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "            OR '" + p_org + "' = 'ALL')  group by E.FULL_NAME,E.PERSON_ID,e.pos_type,e.left_dt,e.JOIN_DT,e.PIT_TAX_NO,E.SAL_PERIOD " ;

string SQL_com
	= "select code_nm,code_fnm from vhr_hr_code v where v.id='HR0131' order by code " ;
string para_com = "'" + p_org + "','" + p_month_to + "'";
        DataTable dt_com2 = ESysLib.TableReadOpenCursor("hr_rpt_company", para_com);
      
//Response.Write(SQL);
//Response.End();

        string TemplateFile = "rpt_certificate_income.xls";
        string TempFile = "../../../system/temp/rpt_certificate_income_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;
      DataTable dt_emp = ESysLib.TableReadOpen(SQL);
	  DataTable dt_com = ESysLib.TableReadOpen(SQL_com);

        if (dt_emp.Rows.Count == 0 ||dt_com.Rows.Count<10)
        {
            Response.Write("There is no data of salary.");
            Response.End();
			
        }

        
  int   pos=43   ;
        int t=0;
        //Show data
        for (int i = 0; i < dt_emp.Rows.Count; i++)
        { 	
			
		
		if(i>0)
			{
			exSheet.Range[pos*(i)+1, pos].Rows.EntireRow.Insert();
			exSheet.Range["A1:M43"].Copy(exSheet.Range["A"+(pos*(i)+1)+":M"+(pos*(i+1))]);
		
			}
		if (dt_com2.Rows[0][3].ToString() != "")
        {
            byte[] MyData = new byte[0];
            MyData = (byte[])dt_com2.Rows[0][3];
            MemoryStream stream = new MemoryStream(MyData);

            Bitmap b = new Bitmap(stream);
			exSheet.Cells["B"+ (2+pos*(i)) ].Select();
            exSheet.Shapes.AddPicture(ResizeImage(b, 200, 140));
        }		
		exSheet.Cells["F"+ (8+pos*(i)) ].Value = dt_com.Rows[0][0].ToString();   
		exSheet.Cells["E"+ (9+pos*(i)) ].Value = dt_com.Rows[0][1].ToString();   
		exSheet.Cells["C"+ (10+pos*(i)) ].Value = dt_com.Rows[1][0].ToString();    
		exSheet.Cells["C"+ (12+pos*(i)) ].Value = dt_com.Rows[2][0].ToString();    
		
		exSheet.Cells["C"+ (16+pos*(i)) ].Value = dt_emp.Rows[i][0].ToString();  
		exSheet.Cells["J"+ (16+pos*(i)) ].Value = dt_emp.Rows[i][1].ToString();  
		exSheet.Cells["C"+ (18+pos*(i)) ].Value = dt_emp.Rows[i][2].ToString();  
		exSheet.Cells["K"+ (18+pos*(i)) ].Value = dt_emp.Rows[i][3].ToString();  
		exSheet.Cells["B"+ (20+pos*(i)) ].Value = "Thu nhập trong giai đoạn từ ngày "+dt_emp.Rows[i][4].ToString()+" đến ngày "+dt_emp.Rows[i][5].ToString()+" như sau:";
		exSheet.Cells["K"+ (24+pos*(i)) ].Value = Double.Parse(dt_emp.Rows[i][6].ToString());  
		exSheet.Cells["K"+ (26+pos*(i)) ].Value = Double.Parse(dt_emp.Rows[i][7].ToString());  
		exSheet.Cells["K"+ (27+pos*(i)) ].Value = Double.Parse(dt_emp.Rows[i][8].ToString());  
		exSheet.Cells["K"+ (28+pos*(i)) ].Value = Double.Parse(dt_emp.Rows[i][9].ToString());  
		exSheet.Cells["K"+ (29+pos*(i)) ].Value = Double.Parse(dt_emp.Rows[i][10].ToString());  
		exSheet.Cells["E"+ (32+pos*(i)) ].Value = "Tân Thành, ngày (date) ....... tháng (month) ....... năm (year) "+(Double.Parse(p_year))+"";
		
           
                //Insert page break
                IPageBreaks pbs = exBook.Worksheets[1].HPageBreaks;
                IRange usedrange = exBook.Worksheets[1].UsedRange;
                //pbs.Reset();
                pbs.Add(usedrange.Rows[(pos *(i+1)) + 1]);
                //end insert page beak
                
          
             
        }
        
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
    
    public Bitmap ResizeImage(Bitmap d, int w, int h)
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