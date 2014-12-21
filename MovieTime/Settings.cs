// Settings.cs
//
// Author: Marc Bernier
//   Date: 2014-12-06

using System;
using System.Xml;

using UnityEngine;

namespace MovieTime {
  public class LoadSettings {
    private string path = "";
    private XmlDocument document = null;
    private XmlElement mainNode = null;
    private XmlElement currentNode = null;

    public LoadSettings(string fileName) {
      path = KSPUtil.ApplicationRootPath.Replace(@"\", "/") + "/GameData/MovieTime/" + fileName;
    }

    public bool Open(string mainNodeName) {
      try {
        document = new XmlDocument();
        document.Load(path);
        mainNode = SelectMainNode(mainNodeName);
        return (mainNode != null);

      } catch (Exception ex) {
        Debug.Log(string.Format("LoadSettings: Open exception: {0}", ex.Message));
        return false;
      }
    }

    private XmlElement SelectMainNode(string nodeName) {
      return (XmlElement)document.GetElementsByTagName(nodeName)[0];
    }

    public bool SelectNode(string nodeName) {
      if (mainNode != null) {
        currentNode = (XmlElement)mainNode.GetElementsByTagName(nodeName)[0];
        return (currentNode != null);
      }
      return false;
    }

    public T Get<T>(string key, T defValue) {
      try {
        string value = "";
        if (currentNode != null && currentNode.GetElementsByTagName(key).Count > 0) {
          value = (currentNode.GetElementsByTagName(key)[0]).InnerText;
          return (T)Convert.ChangeType(value, typeof(T));
        }
      } catch { }
      return defValue;
    }
  }

  public class SaveSettings {
    private string path = "";
    private XmlDocument document = null;
    private XmlElement mainNode = null;
    private XmlElement currentNode = null;

    public SaveSettings(string fileName) {
      path = KSPUtil.ApplicationRootPath.Replace(@"\", "/") + "/GameData/MovieTime/" + fileName;
    }

    public bool Open(string mainNodeName) {
      try {
        document = new XmlDocument();
        document.Load(path);
      } catch { }

      mainNode = SelectMainNode(mainNodeName);
      return (mainNode != null);
    }

    public bool Save() {
      if (document != null && path != "") {
        try {
          document.Save(path);
          return true;
        } catch (Exception ex) {
          Debug.Log(string.Format("SaveSettings: Save exception: {0}", ex.Message));
        }
      }
      return false;
    }

    private XmlElement SelectMainNode(string nodeName) {
      if (document.GetElementsByTagName(nodeName).Count == 0) {
        XmlElement retVal = document.CreateElement(nodeName);
        document.AppendChild(retVal);
        return retVal;
      }
      return (XmlElement)document.GetElementsByTagName(nodeName)[0];
    }

    public bool SelectNode(string nodeName) {
      if (mainNode != null) {
        if (mainNode.GetElementsByTagName(nodeName).Count == 0) {
          currentNode = document.CreateElement(nodeName);
          mainNode.AppendChild(currentNode);
        } else {
          currentNode = (XmlElement)mainNode.GetElementsByTagName(nodeName)[0];
        }
        return (currentNode != null);
      }
      return false;
    }

    public void Set<T>(string key, T value) {
      if (currentNode != null && currentNode.GetElementsByTagName(key).Count == 0) {
        XmlElement field = document.CreateElement(key);
        field.InnerText = value.ToString();
        currentNode.AppendChild(field);
      } else {
        XmlElement field = (XmlElement)currentNode.GetElementsByTagName(key)[0];
        field.InnerText = value.ToString();
      }
    }
  }
}