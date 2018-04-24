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
using System.Text.RegularExpressions;

public partial class rpt_recruitment_list : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ESysLib.SetUser("HR");
        string P_RECRUIT_FLAG,P_POSITION,P_WG_PK,P_FROM_JOINDATE,P_TO_JOINDATE,P_FROM_RECRUITDATE,P_TO_RECRUITDATE,P_TEMP,P_STRTEMP,P_ORG_PK;
 
        P_RECRUIT_FLAG = Request["p_recruit_flag"].ToString();
        P_POSITION = Request["p_pos"].ToString();
        P_WG_PK = Request["p_wgroup"].ToString();
        P_ORG_PK = Request["p_org"].ToString();
        P_FROM_JOINDATE = Request["p_from_joindt"].ToString();
        P_TO_JOINDATE = Request["p_tojoindt"].ToString();
        P_FROM_RECRUITDATE = Request["p_from_recruit"].ToString();
        P_TO_RECRUITDATE = Request["p_to_recruit"].ToString();
        P_TEMP = Request["p_lst_temp"].ToString();
        P_STRTEMP = Request["p_temp"].ToString();


        string SQL
      = " SELECT  " +
          "A.FULL_NAME  " +
          ", A.BIRTH_DT  " +
          ",( select CODE_NM from vhr_hr_code g where id='HR0021' and g.code=A.PLACE_BIRTH)  " +
          ", ( select CODE_NM from vhr_hr_code g where id='HR0007' and g.code=A.SEX)  " +
          ", A.PERMANENT_ADDR  " +
          ", ( select CODE_NM from vhr_hr_code g where id='HR0008' and g.code= A.POS_TYPE)  " +
          ", A.PERSON_ID  " +
          ", A.ISSUE_DT  " +
          ",  ( select CODE_NM from vhr_hr_code g where id='HR0014' and g.code= A.PLACE_PER_ID ) " +
          ",TO_CHAR(TO_DATE(A.join_dt,'YYYYMMDD'),'DD/MM/YYYY')   " +
          ",( select CODE_NM from vhr_hr_code g where id='HR0002' and g.code=A.prob_type ) " +
          " , C.ORG_NM  " +
          ",nvl(A.basic_sal,0)  " +
          ",nvl(A.allow_amt1,0)  " +
          " FROM THR_RECRUITMENT A, " +
          "    TCO_ORG C  " +
          "    WHERE A.DEL_IF = 0  " +
          "    AND C.DEL_IF = 0 " +
          "    AND A.TCO_ORG_PK = C.PK " +
          "    AND   " +
          "    (A.TCO_ORG_PK IN(SELECT G.PK  " +
          "           FROM TCO_ORG G   " +
          "           WHERE G.DEL_IF=0   " +
          "           START WITH G.PK =  '" +  P_ORG_PK +"' " +
          "           CONNECT BY PRIOR  G.PK=G.P_PK)  " +
          "          OR   '" + P_ORG_PK + "' ='ALL')  " +
          "     AND   '" + P_RECRUIT_FLAG + "' = DECODE(   '" + P_RECRUIT_FLAG + "' , 'ALL',   '" + P_RECRUIT_FLAG + "' , NVL(A.RECRUIT_FLAG,'N')) " +
          "     AND  '" + P_POSITION +"' = DECODE(   '" + P_POSITION +"' , 'ALL',   '" + P_POSITION +"' , A.POS_TYPE) " +
          "     AND DECODE (  '" + P_WG_PK +"', 'ALL', 'ALL', A.THR_WG_PK) =   '" + P_WG_PK +"'   " +
          "     AND (   ( '" + P_FROM_JOINDATE + "'  IS NULL AND   '" + P_TO_JOINDATE + "' IS NULL)  " +
          "    OR (A.JOIN_DT BETWEEN  '" + P_FROM_JOINDATE + "'  AND     '" + P_TO_JOINDATE + "'  )  " +
          "      )  " +
          "     AND (   ( '" + P_FROM_RECRUITDATE + "' IS NULL AND   '" + P_TO_RECRUITDATE + "' IS NULL)  " +
          "    OR (A.REC_DT BETWEEN  '" + P_FROM_RECRUITDATE + "'  AND     '" + P_TO_RECRUITDATE + "' )  " +
          "      )  " +
          "     AND (   (  '" + P_TEMP + "'= '1' AND UPPER (A.FULL_NAME) LIKE '%'  || UPPER ('" + P_STRTEMP +"') || '%' ) " +
          "    OR (    '" + P_TEMP + "' = '2'  AND UPPER (A.person_id) LIKE '%'  || UPPER ('" + P_STRTEMP + "') ||    '%'   ) " +
          "     )  " +
          "      ORDER BY  join_dt,FULL_NAME  ";



       // Response.Write(SQL);
       // Response.End();
        DataTable dt_total = ESysLib.TableReadOpen(SQL);
        int irow, icol;
        irow = dt_total.Rows.Count;
        icol = dt_total.Columns.Count;
        if (irow == 0)
        {
            Response.Write("There is no data");
            Response.End();
        }



        string TemplateFile = "rpt_recruitment_list.xls";
        string TempFile = "../../../system/temp/rpt_recruitment_list_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        //IRange range;
        int spos = 3;
        int scol = 1;
        //insert new row
        for (int i = 1; i < irow; i++)
        {
            exSheet.Range[spos + i, 1].Rows.EntireRow.Insert();
        }
         for (int i = 0; i < irow; i++)
        {
            exSheet.Cells[spos + i, 1].Value = i + 1;
            for (int j = 0; j < icol; j++)
            {

                if (j >=12)
                {
                    exSheet.Cells[spos + i, j + scol+1].Value = Double.Parse(dt_total.Rows[i][j].ToString());
                }
                else
                {
                    exSheet.Cells[spos + i, j + scol+1].Value = dt_total.Rows[i][j].ToString();
                }
            }
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
}