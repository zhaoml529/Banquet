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
		// �����������
		SAXReader reader = new SAXReader();
		// ����documentʵ��
		Document doc;
		try {
			doc = reader.read(pic_path);
			List<Object> listEle = doc.selectNodes("/hotel");
			Iterator<Object> itEle = listEle.iterator();
			while (itEle.hasNext()) {
				Element empEle = (Element) itEle.next();
				// emps���ڵ��´���һ��emp�ڵ�
				Element picEle = empEle.addElement("picture");
				// emp�������id="1"
				picEle.addAttribute("id", hotel_id);
				//emp�ڵ��´���һ��name�ڵ�
//		        Element nameEle = empEle.addElement("url");
		        //name�ڵ��´���һ���ı��ڵ�zhangsan
//		        nameEle.setText("");
			}
			Writer out = new FileWriter(pic_path);
			// ��ʽ�����,����IE���һ��
			OutputFormat format = OutputFormat.createPrettyPrint();
			// OutputFormat format = OutputFormat.createCompactFormat();
			format.setEncoding("UTF-8");
			//format.setEncoding("GBK");
			// ����д������
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
		// �����������
		SAXReader reader = new SAXReader();
		// ����documentʵ��
		Document doc;
		try {
			doc = reader.read(pic_path);
			List<Object> listEle = doc.selectNodes("/hotel/picture");
			Iterator<Object> itEle = listEle.iterator();
			while (itEle.hasNext()) {
				Element empEle = (Element) itEle.next();
				// Ҫɾ����hotel_id��ͼƬ
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
		// �����������
		SAXReader reader = new SAXReader();
		// ����documentʵ��
		Document doc;
			doc = reader.read(pic_path);
			List<Object> listEle = doc.selectNodes("/hotel");
			Iterator<Object> itEle = listEle.iterator();
			while (itEle.hasNext()) {
				Element empEle = (Element) itEle.next();
				
				Iterator it=empEle.elementIterator("picture");//ָ����picture
				while(it.hasNext())
				{
					Element es=(Element) it.next();//����������picture�ڵ�
					// Ҫɾ����hotel_id��ͼƬ
					if (hotel_id.equals(es.attributeValue("id"))) {
						// ����picture�µ�url�ڵ�
						Iterator<Object> itUrl = es.elementIterator("url");
						Iterator<Object> itTitle = es.elementIterator("title");
						while (itUrl.hasNext()) {
							Element urlEle = (Element) itUrl.next();
							Element titleEle = (Element) itTitle.next();
							// ɾ��url��title�ڵ�
							es.remove(urlEle);
							es.remove(titleEle);
							empEle.remove(es);
							break;
						}
					}
				}
			}
			// ����д����
			Writer out = new FileWriter(pic_path);
			// ��ʽ�����
			OutputFormat format = OutputFormat.createPrettyPrint();
			// OutputFormat format = OutputFormat.createCompactFormat();
			format.setEncoding("UTF-8");
			//format.setEncoding("GBK");
			// ����д������
			XMLWriter writer = new XMLWriter(out, format);
			writer.write(doc);
			writer.close();
	}

	public static void addXML(String hotel_id, String picURL, String title, String pic_path) throws DocumentException, IOException {
		// �����������
		SAXReader reader = new SAXReader();
		// ����documentʵ��
		Document doc;
			doc = reader.read(pic_path);
			List<Object> listEle = doc.selectNodes("/hotel/picture");
			Iterator<Object> itEle = listEle.iterator();
			while (itEle.hasNext()) {
				Element empEle = (Element) itEle.next();
				// Ҫɾ����hotel_id��ͼƬ
				if (hotel_id.equals(empEle.attributeValue("id"))) {
					Iterator<Object> itUrl = empEle.elementIterator("url");
					if(!itUrl.hasNext()){
						// picture�ڵ��´���һ��url�ڵ�
						Element urlEle = empEle.addElement("url");
						// url�ڵ��´���һ���ı��ڵ�picURL
						urlEle.setText(picURL);
						// ��Ϊurl����һ���ֵܽڵ�title
						Element titEle = empEle.addElement("title");
						// title�ڵ��´���һ���ı��ڵ�
						titEle.setText(title);
						break;
					}
				}
			}
			// ����д����
			Writer out = new FileWriter(pic_path);
			// ��ʽ�����
			OutputFormat format = OutputFormat.createPrettyPrint();
			// OutputFormat format = OutputFormat.createCompactFormat();
			//format.setEncoding("GBK");
			format.setEncoding("UTF-8");
			// ����д������
			XMLWriter writer = new XMLWriter(out, format);
			writer.write(doc);
			writer.close();
	}

	public static List<Hotel> listXML(String pic_path){
		List<Hotel> listURL = new ArrayList<Hotel>();
		// �����������
		SAXReader reader = new SAXReader();
		// ����documentʵ��
		Document doc;
		List<Object> listText = null;
		try {
			doc = reader.read(pic_path);
			//����emp�µ�name�ڵ�
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