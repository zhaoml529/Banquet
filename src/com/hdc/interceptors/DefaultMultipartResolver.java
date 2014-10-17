package com.hdc.interceptors;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.commons.CommonsMultipartResolver;

/**
 * ���springMVC��kindEditor�ļ��ϴ�ʱ������
 * org.springframework.web.multipart.commons.CommonsMultipartResolver��springĬ���ṩ��,
 * ������һ��public boolean isMultipart(HttpServletRequest request) �ӿ�,
 * ����ӿ������ж���Щrequest��spring��CommonsMultipartResolver����.
 * ����,�Լ�дһ��CommonsMultipartResolver������,����isMultipart����,��spring����������.
 * �����Ļ����ض�������Ϳ����ƹ�spring����еĽ������,
 * @author Administrator
 *
 */
public class DefaultMultipartResolver extends CommonsMultipartResolver {
	//com.rjxy.action.KindEditorController�����еı���·��
	private static final String ATTACHED = "file_upload";
    @Override
    public boolean isMultipart(HttpServletRequest request) {
        if (request.getRequestURI().contains(ATTACHED)) {
            return false;
        }
        return super.isMultipart(request);
    }
}
