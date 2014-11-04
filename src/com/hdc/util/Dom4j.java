package com.hdc.util;

import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.log4j.Logger;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;

import com.hdc.entity.Hotel;

public class Dom4j {
	private static Logger log = Logger.getLogger(Dom4j.class);
	public static void createXML(String hotel_id, String pic_path) {
		// 创建读入对象
		SAXReader reader = new SAXReader();
		// 创建document实例
		Document doc;
		try {
			doc = reader.read(pic_path);
			List<Object> listEle = doc.selectNodes("/hotel");
			Iterator<Object> itEle = listEle.iterator();
			while (itEle.hasNext()) {
				Element empEle = (Element) itEle.next();
				// emps根节点下创建一个emp节点
				Element picEle = empEle.addElement("picture");
				// emp添加属性id="1"
				picEle.addAttribute("id", hotel_id);
				//emp节点下创建一个name节点
//		        Element nameEle = empEle.addElement("url");
		        //name节点下创建一个文本节点zhangsan
//		        nameEle.setText("");
			}
			Writer out = new FileWriter(pic_path);
			// 格式化输出,类型IE浏览一样
			OutputFormat format = OutputFormat.createPrettyPrint();
			// OutputFormat format = OutputFormat.createCompactFormat();
			format.setEncoding("UTF-8");
			//format.setEncoding("GBK");
			// 创建写出对象
			XMLWriter writer = new XMLWriter(out, format);
			writer.write(doc);
			writer.close();
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			log.error(e);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			log.error(e);
		}
	}


	public static boolean searchXML(String hotel_id, String pic_path) {
		boolean flag = false;
		// 创建读入对象
		SAXReader reader = new SAXReader();
		// 创建document实例
		Document doc;
		try {
			doc = reader.read(pic_path);
			List<Object> listEle = doc.selectNodes("/hotel/picture");
			Iterator<Object> itEle = listEle.iterator();
			while (itEle.hasNext()) {
				Element empEle = (Element) itEle.next();
				// 要删除的hotel_id的图片
				if (hotel_id.equals(empEle.attributeValue("id"))) {
					flag = true;
					break;
				}
			}
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			log.error(e);
		}
		return flag;

	}

	public static void deleteXML(String hotel_id, String pic_path) throws IOException, DocumentException{
		// 创建读入对象
		SAXReader reader = new SAXReader();
		// 创建document实例
		Document doc;
			doc = reader.read(pic_path);
			List<Object> listEle = doc.selectNodes("/hotel");
			Iterator<Object> itEle = listEle.iterator();
			while (itEle.hasNext()) {
				Element empEle = (Element) itEle.next();
				
				Iterator it=empEle.elementIterator("picture");//指定到picture
				while(it.hasNext())
				{
					Element es=(Element) it.next();//迭代的所有picture节点
					// 要删除的hotel_id的图片
					if (hotel_id.equals(es.attributeValue("id"))) {
						// 查找picture下的url节点
						Iterator<Object> itUrl = es.elementIterator("url");
						Iterator<Object> itTitle = es.elementIterator("title");
						while (itUrl.hasNext()) {
							Element urlEle = (Element) itUrl.next();
							Element titleEle = (Element) itTitle.next();
							// 删除url和title节点
							es.remove(urlEle);
							es.remove(titleEle);
							empEle.remove(es);
							break;
						}
					}
				}
			}
			// 创建写出流
			Writer out = new FileWriter(pic_path);
			// 格式化输出
			OutputFormat format = OutputFormat.createPrettyPrint();
			// OutputFormat format = OutputFormat.createCompactFormat();
			format.setEncoding("UTF-8");
			//format.setEncoding("GBK");
			// 创建写出对象
			XMLWriter writer = new XMLWriter(out, format);
			writer.write(doc);
			writer.close();
	}

	public static void addXML(String hotel_id, String picURL, String title, String pic_path) throws DocumentException, IOException {
		// 创建读入对象
		SAXReader reader = new SAXReader();
		// 创建document实例
		Document doc;
			doc = reader.read(pic_path);
			List<Object> listEle = doc.selectNodes("/hotel/picture");
			Iterator<Object> itEle = listEle.iterator();
			while (itEle.hasNext()) {
				Element empEle = (Element) itEle.next();
				// 要删除的hotel_id的图片
				if (hotel_id.equals(empEle.attributeValue("id"))) {
					Iterator<Object> itUrl = empEle.elementIterator("url");
					if(!itUrl.hasNext()){
						// picture节点下创建一个url节点
						Element urlEle = empEle.addElement("url");
						// url节点下创建一个文本节点picURL
						urlEle.setText(picURL);
						// 再为url创建一个兄弟节点title
						Element titEle = empEle.addElement("title");
						// title节点下创建一个文本节点
						titEle.setText(title);
						break;
					}
				}
			}
			// 创建写出流
			Writer out = new FileWriter(pic_path);
			// 格式化输出
			OutputFormat format = OutputFormat.createPrettyPrint();
			// OutputFormat format = OutputFormat.createCompactFormat();
			//format.setEncoding("GBK");
			format.setEncoding("UTF-8");
			// 创建写出对象
			XMLWriter writer = new XMLWriter(out, format);
			writer.write(doc);
			writer.close();
	}

	public static List<Hotel> listXML(String pic_path){
		List<Hotel> listURL = new ArrayList<Hotel>();
		// 创建读入对象
		SAXReader reader = new SAXReader();
		// 创建document实例
		Document doc;
		List<Object> listText = null;
		try {
			doc = reader.read(pic_path);
			//查找emp下的name节点
	        listText = doc.selectNodes("/hotel/picture");
	        Iterator<Object> itText = listText.iterator();
	        while(itText.hasNext()){
	            Element textEle = (Element) itText.next();
	            Hotel hotel = new Hotel();
	            hotel.setJdbh(Integer.parseInt(textEle.attributeValue("id")));
	            hotel.setJdmc(textEle.element("title").getText());
	            hotel.setJdzp(textEle.element("url").getText());
	            listURL.add(hotel);
	        }
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.error(e);
		}
		return listURL;
	}
	
	public static void main(String[] args) {
		// new Dom4j().updateXML();
		// createXML(new String[]{"1","2","3","4"}, new
		// String[]{"url1","url2","url3","url4"}, "213");
		// deleteXML("3");
		//addXML("3","222222222222", "C:\\Tomcat\\webapps\\Banquet\\WEB-INF\\carousel_pic.xml");
		createXML("2","C:\\Tomcat\\webapps\\Banquet\\WEB-INF\\carousel_pic.xml");

	}
}