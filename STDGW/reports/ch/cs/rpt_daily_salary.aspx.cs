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

public partial class rpt_daily_salary : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //ESysLib.SetUser("hr");
        ESysLib.SetUser(Session["APP_DBUSER"].ToString());

	   string P_TCO_ORG_PK = Request["P_TCO_ORG_PK"].ToString();
	   string P_THR_WG_PK  = Request["P_THR_WG_PK"].ToString();
	   string P_STATUS   = Request["P_STATUS"].ToString();
	   string P_EMPLOYEE_TYPE = Request["P_EMPLOYEE_TYPE"].ToString();
	   string P_SEARCH_BY     = Request["P_SEARCH_BY"].ToString();
	   string P_SEARCH_TEMP  = Request["P_SEARCH_TEMP"].ToString();
	   string P_FROM_DT  = Request["P_FROM_DT"].ToString();
	   string P_TO_DT    = Request["P_TO_DT"].ToString();
	   string P_COST_GROUP  = Request["P_COST_GROUP"].ToString();
	   string P_COST_KIND       = Request["P_COST_KIND"].ToString();
	   string P_TAC_ABPL_PK     = Request["P_TAC_ABPL_PK"].ToString();
      //--------------------company information-----------------------
    string SQL_Com
	= " select  a.PARTNER_NAME,a.addr1,a.tax_code,b.data " + 
        " from tco_company a,tco_bpphoto b " +
        " where a.DEL_IF=0  and b.del_if(+)=0 and a.tco_bpphoto_pk=b.pk(+) " +
        " and a.pk in ( select tco_company_pk from  " +
        "               tco_org  f " +
        "               where  f.pk IN ( " +
        "                              SELECT     g.pk " +
        "                                    FROM tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + P_TCO_ORG_PK + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + P_TCO_ORG_PK + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" +P_TCO_ORG_PK + "' = 'ALL') " +
        "and rownum=1 " ;

		DataTable dt_Com = ESysLib.TableReadOpen(SQL_Com);
	    int irow_com;
		irow_com = dt_Com.Rows.Count;

		string SQL
		= " SELECT A.WORK_DT " + 
        "        ,D.ORG_NM " +
        "        ,A.DEPT_NM " +
        "        ,ROUND(SUM(NVL(A.SALARY_LEVEL1,0)),10) " +
        "        ,ROUND(SUM(NVL(A.SALARY_LEVEL2,0)),10) " +
        "        ,ROUND(SUM(NVL(WT_H,0)),10) " +
        "        ,ROUND(SUM(NVL(ABS_H,0)),10) " +
        "        ,ROUND(SUM(NVL(A.OT_H,0) ),10) " +
        "        ,ROUND(SUM(NVL(A.NT_H,0)),10) " +
        "        ,ROUND(SUM(NVL(A.ST_H,0)),10) " +
        "        ,ROUND(SUM(NVL(A.HT_H,0) ),10) " +
        "        ,ROUND(SUM(NVL(A.TOTAL_WT_AMT,0)),10) " +
        "        ,ROUND(SUM(NVL(A.TOTAL_OT_AMT,0)),10) " +
        "        ,ROUND(SUM(NVL(A.NET_AMT,0)),10) " +
        "        FROM THR_DAILY_SALARY A,TCO_ORG B,TCO_ORG D, " +
        "        (SELECT G.CODE,G.CODE_NM FROM VHR_HR_CODE G WHERE G.ID='HR0003' " +
        "         UNION ALL " +
        "         SELECT G.CODE,G.CODE_NM FROM VHR_HR_CODE G WHERE G.ID='HR0200') ATTEND_TYPE " +
        "      WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND A.TCO_DEPT_PK=B.PK AND B.P_PK=D.PK  " +
        "        AND A.ATTEND_TYPE=ATTEND_TYPE.CODE(+)  " +
        "        AND DECODE('" + P_STATUS + "','ALL','ALL',A.STATUS )='" + P_STATUS + "' " +
        "        AND DECODE('" + P_EMPLOYEE_TYPE + "','ALL','ALL',A.EMPLOYEE_TYPE )='" + P_EMPLOYEE_TYPE + "' " +
        "        AND (('" + P_SEARCH_BY + "'='1' AND UPPER(A.FULL_NAME) LIKE  '%' || UPPER('" + P_SEARCH_TEMP + "')|| '%') " +
        "        OR ('" + P_SEARCH_BY + "'='2' AND UPPER(A.EMP_ID) LIKE  '%' || UPPER('" + P_SEARCH_TEMP + "')|| '%') " +
        "        ) " +
        "        AND (('" + P_FROM_DT + "' IS NULL AND '" + P_TO_DT + "' IS NULL) " +
        "        OR (A.WORK_DT BETWEEN '" + P_FROM_DT + "' AND '" + P_TO_DT + "') ) " +
        "        AND DECODE('" + P_COST_GROUP + "','ALL','ALL',A.COST_GROUP )='" + P_COST_GROUP + "' " +
        "        AND DECODE('" + P_COST_KIND + "','ALL','ALL',A.COST_KIND )='" + P_COST_KIND + "' " +
        "        AND DECODE('" + P_TAC_ABPL_PK + "','ALL','ALL',A.TAC_ABPL_PK )='" + P_TAC_ABPL_PK + "' " +
        "        AND (   A.TCO_DEPT_PK IN ( " +
        "                    SELECT     G.PK " +
        "                    FROM TCO_ORG G " +
        "                    WHERE G.DEL_IF = 0 " +
         "                    START WITH G.PK = " +
        "                    DECODE ('" + P_TCO_ORG_PK + "', " +
        "                        'ALL', 0, " +
        "                        '" + P_TCO_ORG_PK + "' " +
        "                    ) " +
        "                    CONNECT BY PRIOR G.PK = G.P_PK) " +
        "                    OR '" + P_TCO_ORG_PK + "' = 'ALL')  " +
        "        GROUP BY A.WORK_DT,D.PK,D.ORG_NM,A.TCO_DEPT_PK,A.DEPT_NM " +
        "        ORDER BY A.WORK_DT,D.ORG_NM,A.DEPT_NM " ;

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
   
        string TemplateFile = "rpt_daily_salary.xls";
        string TempFile = "../../../system/temp/rpt_daily_salary_" + Session["User_ID"].ToString() + ".xls";
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
		exSheet.Cells["C1"].Value = dt_Com.Rows[0][0].ToString();
		exSheet.Cells["C2"].Value = dt_Com.Rows[0][1].ToString();
		exSheet.Cells["C3"].Value = dt_Com.Rows[0][2].ToString();
		MemoryStream stream;
        Bitmap b;
        if (dt_Com.Rows[0][3].ToString().Length != 0)
        {
            byte[] MyData = new byte[0];
            MyData = (byte[])dt_Com.Rows[0][3];
            stream = new MemoryStream(MyData);

            b = new Bitmap(stream);
            exSheet.Cells[ 1, 1].Select();
            exSheet.Shapes.AddPicture(ESysLib.ResizeImage(b, 130, 70));
        }
		int spos = 6;
        int scol = 1;
        int inumber_col=3;
		for (int i = 1; i < irow_emp; i++)
        {
            exSheet.Range[spos + i, 1].Rows.EntireRow.Insert();
        }
		double[] Group_Total=new double[icol_emp];	
		for (int j = 0; j < icol_emp; j++)
		{
			Group_Total[j] = 0;
		}
         for (int i = 0; i < irow_emp; i++)
        {
			scol=1;
			exSheet.Cells[spos , scol].Value=i+1;
			scol++;
            for (int j = 0; j < icol_emp; j++)
            {
				if (j==0)
				{
					exSheet.Cells[spos, j + scol].Value = new DateTime(int.Parse(dt_emp.Rows[i][j].ToString().Substring(0, 4)), int.Parse(dt_emp.Rows[i][j].ToString().Substring(4, 2)), int.Parse(dt_emp.Rows[i][j].ToString().Substring(6, 2)));
				}
				else if (j >=inumber_col)
                {
                    exSheet.Cells[spos , j + scol].Value = Double.Parse(dt_emp.Rows[i][j].ToString());
					Group_Total[j] += double.Parse(dt_emp.Rows[i][j].ToString());
                }
                else

                {
                    exSheet.Cells[spos , j + scol].Value = dt_emp.Rows[i][j].ToString();
                }
            }
			spos++;
        }
		
		for(int j = inumber_col; j < icol_emp; j++)
		{
			exSheet.Cells[spos, j + scol].Value = Group_Total[j];
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