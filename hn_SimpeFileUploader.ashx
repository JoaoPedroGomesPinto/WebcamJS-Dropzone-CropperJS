<%@ WebHandler Language="C#" Class="hn_SimpeFileUploader" %>

using System.Web;
using System.IO;
using System;

public class hn_SimpeFileUploader : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";

        string dirFullPath = HttpContext.Current.Server.MapPath("~/MediaUploader/");
        string[] files;
        files = Directory.GetFiles(dirFullPath);

        string str_image = "";
        CheckFiles(dirFullPath);
        foreach (string s in context.Request.Files)
        {
            HttpPostedFile file = context.Request.Files[s];
            string fileName = file.FileName;
            string fileExtension = file.ContentType;

            if (!string.IsNullOrEmpty(fileName))
            {
                fileExtension = Path.GetExtension(fileName);
                str_image = string.Format(@"{0}.jpeg", Guid.NewGuid());
                string pathToSave = HttpContext.Current.Server.MapPath("~/MediaUploader/") + str_image;
                file.SaveAs(pathToSave);
            }
        }
        context.Response.Write(str_image);
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

    public void CheckFiles(string dirName)
    {
        string[] files = Directory.GetFiles(dirName);
        DateTime dtNow = DateTime.Now;

        foreach (string file in files)
        {
            FileInfo fi = new FileInfo(file);
            if (fi.LastAccessTime < DateTime.Now.AddDays(-30))
                fi.Delete();
        }
    }



}