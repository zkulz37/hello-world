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

public partial class rpt_time_summary_year_new : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //ESysLib.SetUser("hr");
        ESysLib.SetUser(Session["APP_DBUSER"].ToString());

        string p_user, p_tco_org_pk, p_wg, p_year, p_search_by;
        string p_search_temp, p_search_ot, p_ot, p_nation;


        p_tco_org_pk = Request["p_tco_org_pk"].ToString();
        p_wg = Request["p_wg"].ToString();
        p_year = Request["p_year"].ToString();
        p_search_by = Request["p_search_by"].ToString();
        p_search_temp = Request["p_search_temp"].ToString();
        p_search_ot = Request["p_search_ot"].ToString();
        p_ot = Request["p_ot"].ToString();
        p_user = Request["p_user"].ToString();
        p_nation = Request["p_nation"].ToString();


        string TemplateFile = "rpt_time_summary_year_new.xls";
        string TempFile = "../../../system/temp/rpt_time_summary_year_new_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;


        string SQL
     = " SELECT to_char(sysdate,'dd/mm/yyyy'),PR_OT.ORG_NM,PR_OT.WGROUP_NM,PR_OT.EMP_ID,PR_OT.FULL_NAME " +
         "        ,TO_CHAR(TO_DATE(PR_OT.JOIN_DT,'YYYYMMDD'),'DD/MM/YYYY') " +
         "        ,DECODE(PR_OT.T1,0,'',PR_OT.T1) " +
         "        ,DECODE(PR_OT.T2,0,'',PR_OT.T2) " +
         "        ,DECODE(PR_OT.T3,0,'',PR_OT.T3) " +
         "        ,DECODE(PR_OT.T4,0,'',PR_OT.T4) " +
         "        ,DECODE(PR_OT.T5,0,'',PR_OT.T5) " +
         "        ,DECODE(PR_OT.T6,0,'',PR_OT.T6) " +
         "        ,DECODE(PR_OT.T7,0,'',PR_OT.T7) " +
         "        ,DECODE(PR_OT.T8,0,'',PR_OT.T8) " +
         "        ,DECODE(PR_OT.T9,0,'',PR_OT.T9) " +
         "        ,DECODE(PR_OT.T10,0,'',PR_OT.T10) " +
         "        ,DECODE(PR_OT.T11,0,'',PR_OT.T11) " +
         "        ,DECODE(PR_OT.T12,0,'',PR_OT.T12) " +
         "        ,PR_OT.T1+PR_OT.T2+PR_OT.T3+PR_OT.T4+PR_OT.T5 " +
         "         +PR_OT.T6+PR_OT.T7+PR_OT.T8+PR_OT.T9+PR_OT.T10+PR_OT.T11+PR_OT.T12 AS TOTAL " +
         "        FROM( " +
         "        SELECT D.ORG_NM AS ORG_NM,B.WORKGROUP_NM AS WGROUP_NM,V.EMP_ID AS EMP_ID,V.FULL_NAME AS FULL_NAME,V.JOIN_DT AS JOIN_DT, V.PK as PK " +
         "        ,SUM(DECODE(SUBSTR(A.WORK_DT,5,2),'01',NVL(A.OT_TIME,0),0)) AS T1 " +
         "        ,SUM(DECODE(SUBSTR(A.WORK_DT,5,2),'02',NVL(A.OT_TIME,0),0)) AS T2 " +
         "        ,SUM(DECODE(SUBSTR(A.WORK_DT,5,2),'03',NVL(A.OT_TIME,0),0)) AS T3 " +
         "        ,SUM(DECODE(SUBSTR(A.WORK_DT,5,2),'04',NVL(A.OT_TIME,0),0)) AS T4 " +
         "        ,SUM(DECODE(SUBSTR(A.WORK_DT,5,2),'05',NVL(A.OT_TIME,0),0)) AS T5 " +
         "        ,SUM(DECODE(SUBSTR(A.WORK_DT,5,2),'06',NVL(A.OT_TIME,0),0)) AS T6 " +
         "        ,SUM(DECODE(SUBSTR(A.WORK_DT,5,2),'07',NVL(A.OT_TIME,0),0)) AS T7 " +
         "        ,SUM(DECODE(SUBSTR(A.WORK_DT,5,2),'08',NVL(A.OT_TIME,0),0)) AS T8 " +
         "        ,SUM(DECODE(SUBSTR(A.WORK_DT,5,2),'09',NVL(A.OT_TIME,0),0)) AS T9 " +
         "        ,SUM(DECODE(SUBSTR(A.WORK_DT,5,2),'10',NVL(A.OT_TIME,0),0)) AS T10 " +
         "        ,SUM(DECODE(SUBSTR(A.WORK_DT,5,2),'11',NVL(A.OT_TIME,0),0)) AS T11 " +
         "        ,SUM(DECODE(SUBSTR(A.WORK_DT,5,2),'12',NVL(A.OT_TIME,0),0))  AS T12 " +
         "        FROM THR_EXTRA_TIME A,THR_EMPLOYEE V,THR_WORK_GROUP B,tco_org D " +
         "        WHERE A.DEL_IF=0 AND V.DEL_IF=0 AND B.DEL_IF=0 AND A.OT_TYPE NOT IN ('NT','NT2') AND D.DEL_IF=0  " +
         "         AND A.THR_EMP_PK=V.PK AND V.THR_WG_PK=B.PK AND V.TCO_ORG_PK=D.PK " +
         "         AND SUBSTR(A.WORK_DT,1,4)='" + p_year + "' " +
         "            AND DECODE('" + p_nation + "' ,'ALL', '" + p_nation + "',v.nation) =  '" + p_nation + "'" +
         "         AND DECODE('" + p_wg + "' ,'ALL','ALL',B.PK) = '" + p_wg + "'  ";
        SQL = SQL + "                   AND (    V.TCO_ORG_PK IN ( ";
        SQL = SQL + "                       SELECT     G.PK ";
        SQL = SQL + "                             FROM TCO_ORG G ";
        SQL = SQL + "                            WHERE G.DEL_IF = 0           ";
        SQL = SQL + "                       START WITH G.PK = ";
        SQL = SQL + "                                     DECODE ('" + p_tco_org_pk + "', ";
        SQL = SQL + "                                             'ALL', 0, ";
        SQL = SQL + "                                             '" + p_tco_org_pk + "' ";
        SQL = SQL + "                                            ) ";
        SQL = SQL + "                       CONNECT BY PRIOR G.PK = G.P_PK) ";
        SQL = SQL + "                 OR '" + p_tco_org_pk + "' = 'ALL') " +
        "            AND (DECODE('" + p_search_by + "' ,'1',UPPER(V.EMP_ID),'2',V.ID_NUM,'3',UPPER(V.FULL_NAME)) LIKE '%'||UPPER('" + p_search_temp + "' ) " +
        "                        OR '" + p_search_temp + "'  IS NULL) " +
        "          " +
        "        GROUP BY D.ORG_NM,B.WORKGROUP_NM,V.EMP_ID,V.FULL_NAME,V.JOIN_DT,V.PK  " +
        "        HAVING ((SUM(NVL(A.OT_TIME,0))>=nvl('" + p_ot + "' ,0) AND '" + p_search_ot + "' =1) OR (SUM(NVL(A.OT_TIME,0)) < nvl('" + p_ot + "' ,0) AND '" + p_search_ot + "'  =2)) " +
        "        ORDER BY d.org_nm,B.WORKGROUP_NM,V.EMP_ID " +
        "        )PR_OT ";


        //----------------------------------

       
        //Response.Write(SQL);
        //Response.End();
        DataTable dt_total = ESysLib.TableReadOpen(SQL);
        int irow,icol;
        irow = dt_total.Rows.Count;
        icol = dt_total.Columns.Count;
        if (irow == 0)
        {
            Response.Write("There is no data");
            Response.End();
        }

        exSheet.Cells[1, 1].Value = "OVERTIME SUMMARY IN YEAR " + p_year;
       
        exSheet.Cells[2, 16].Value = p_user;
        
       
        exSheet.Cells[3, 16].Value = dt_total.Rows[0][0].ToString();

        

        int i;
        int row_pos = 8;

        //insert row
        for (i = 0; i < irow - 1; i++)
        {

            exSheet.Range[row_pos + i, 1].Rows.EntireRow.Insert();
        }

        exSheet.Range[row_pos-1, 1, row_pos-1, 19].Borders[XlBordersIndex.xlEdgeTop].LineStyle = XlLineStyle.xlContinuous;
        exSheet.Range[row_pos + irow-1 , 1, row_pos + irow-1 , 19].Borders[XlBordersIndex.xlEdgeTop].LineStyle = XlLineStyle.xlContinuous;

        //show data
        row_pos = 7;
        for (i = 0; i < irow; i++)
        {
            exSheet.Cells[row_pos + i, 1].Value = i + 1;
            for (int j = 1; j < icol ; j++)
            {                
                if (IsNumeric(dt_total.Rows[i][j].ToString()))
                {
                    exSheet.Cells[row_pos + i, j + 1].Value = Double.Parse(dt_total.Rows[i][j].ToString()); 
                }
                else
                {
                    exSheet.Cells[row_pos + i, j + 1].Value = dt_total.Rows[i][j].ToString();
                }                
            }
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