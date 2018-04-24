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

public partial class rpt_delegation_letter : System.Web.UI.Page
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
	= "select E.FULL_NAME,E.FULL_FNAME,(select V.CODE_FNM from vhr_hr_code v where  v.id='HR0009' and v.code=e.nation ),(select V.CODE_NM from vhr_hr_code v where v.id='HR0009' and v.code=e.nation ), " + 
        "  E.PERSON_ID ,E.PIT_TAX_NO " +
        "   from thr_employee e where e.del_if=0 " +
		"    and decode('" + p_wg + "','ALL','" + p_wg + "',e.THR_WG_PK)='" + p_wg + "'  " +
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
        "            OR '" + p_org + "' = 'ALL')  " ;


//Response.Write(SQL);
//Response.End();

        string TemplateFile = "rpt_delegation_letter.xls";
        string TempFile = "../../../system/temp/rpt_delegation_letter_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;
      DataTable dt_emp = ESysLib.TableReadOpen(SQL);

        if (dt_emp.Rows.Count == 0)
        {
            Response.Write("There is no data of salary.");
            Response.End();
        }

        
  int   pos=43   ;
        int t=0;
        //Show data
        for (int i = 0; i < dt_emp.Rows.Count; i++)
        { 	if(i>0)
			{
			exSheet.Range[pos*(i)+1, pos].Rows.EntireRow.Insert();
			exSheet.Range["A1:M43"].Copy(exSheet.Range["A"+(pos*(i)+1)+":M"+(pos*(i+1))]);
			t=1;
			}
				
		exSheet.Cells["A"+ (13+pos*(i)) ].Value = "Năm / Year: "+p_year;
        exSheet.Cells["C"+ (15+pos*(i)) ].Value = dt_emp.Rows[i][0].ToString();   
		exSheet.Cells["C"+ (16+pos*(i)) ].Value = dt_emp.Rows[i][1].ToString();
		exSheet.Cells["H"+ (15+pos*(i)) ].Value = "Quốc tịch :"+dt_emp.Rows[i][2].ToString();   
		exSheet.Cells["H"+ (16+pos*(i)) ].Value = "Nationality :"+dt_emp.Rows[i][3].ToString();
        exSheet.Cells["B"+ (18+pos*(i)) ].Value = "Số CMND/ Passport:"+dt_emp.Rows[i][4].ToString();   
		exSheet.Cells["B"+ (19+pos*(i)) ].Value = "ID No. /Passport :"+dt_emp.Rows[i][4].ToString();
		exSheet.Cells["H"+ (18+pos*(i)) ].Value = "Mã số thuế :"+dt_emp.Rows[i][5].ToString();   
		exSheet.Cells["H"+ (19+pos*(i)) ].Value = "Tax code :"+dt_emp.Rows[i][5].ToString();   
		
		exSheet.Cells["B"+ (21+pos*(i)) ].Value = "Năm "+p_year+" tôi chỉ có thu nhập chịu thuế tại một nơi là Công ty TNHH POSCO SS-VINA. Đề";
		exSheet.Cells["A"+ (23+pos*(i)) ].Value = " thuế thu nhập cá nhân năm "+p_year+" với cơ quan thuế.";
		exSheet.Cells["B"+ (24+pos*(i)) ].Value = "In "+p_year+" I only have taxable income in one place at POSCO SS-VINA Co. Ltd. I would like to";
		exSheet.Cells["A"+ (25+pos*(i)) ].Value = "request POSCO SS-VINA Co. Ltd (Tax code : 3501620257) to finalize the personal income tax in "+p_year+"";
		exSheet.Cells["E"+ (33+pos*(i)) ].Value = "Tân Thành, ngày (date) ....... tháng (month) ....... năm (year) "+(Double.Parse(p_year)+1)+"";
		exSheet.Cells["F"+ (43+pos*(i)) ].Value = dt_emp.Rows[i][0].ToString();   
		
           
                //Insert page break
                IPageBreaks pbs = exBook.Worksheets[1].HPageBreaks;
                IRange usedrange = exBook.Worksheets[1].UsedRange;
                //pbs.Reset();
                pbs.Add(usedrange.Rows[(pos *(i+1)) + 1]);
                //end insert page beak
                
          
             
        }
        //Hide allowance column
        
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