package com.aladdin.platform.controller;

import com.aladdin.core.bo.AldOrgServiceBo;
import com.aladdin.core.bo.OrgAttachmentBo;
import com.aladdin.core.bo.OrgBo;
import com.aladdin.core.bo.ServiceBo;
import com.aladdin.core.constant.Constant;
import com.aladdin.core.service.IConstantsCoreService;
import com.aladdin.core.service.IOrgCoreService;
import com.aladdin.core.service.IProCityDistrictService;
import com.aladdin.core.service.ISrvOrderCoreService;
import com.aladdin.core.vo.*;
import com.aladdin.platform.bo.view.CompanyInfoView;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.wl.framework.session.context.SessionContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/company")
public class CompanyController {
    @Resource (name = "constantsCoreService")
    private IConstantsCoreService constantsCoreService;
    @Resource(name = "fwSessionContext")
    private SessionContext sessionContext;
    @Resource(name="orgCoreService")
    private IOrgCoreService orgCoreService;
    @Resource(name = "proCityDistrictService")
    private IProCityDistrictService proCityDistrictService;
    @Resource(name="srvOrderCoreService")
    private ISrvOrderCoreService srvOrderCoreService;

    @RequestMapping("/info")
    public String list(Model model) {

        //根据用户名查询企业ID
        Long curUser = sessionContext.getLoginUser().getUserId();
        //根据用户ID 查询公司基本信息
        OrgBo orgBo = orgCoreService.getOrgByUserId(curUser);
        CompanyInfoView companyInfoView=new CompanyInfoView();
        if(null!=orgBo) {
             companyInfoView = this.queryCompanyInfo(orgBo.getId());
        }
        model.addAttribute("companyInfo",companyInfoView);
        System.out.println(new Gson().toJson(model));
        return "company/info";
    }

    @RequestMapping("/{id}/edit")
    public String viewEdit(Model model,@PathVariable(value = "id") Long id){
        CompanyInfoView companyInfoView=queryCompanyInfo(id);
        model.addAttribute("companyInfo",companyInfoView);
        System.out.println(new Gson().toJson(companyInfoView));
        return "company/edit";
    }

    private CompanyInfoView queryCompanyInfo(Long id){
        CompanyInfoView companyInfoView=new CompanyInfoView();
        //根据企业ID 查询企业所有附件
        OrgQueryVo queryVo=new OrgQueryVo();
        queryVo.setId(id);
        OrgBo orgBo = orgCoreService.getOrgByOrgId(id);
        if(orgBo.getIsThree()==null)orgBo.setIsThree(0);
        companyInfoView.setOrgBo(orgBo);
        OrgAttachmentQueryVo orgAttachmentQueryVo =  new OrgAttachmentQueryVo();
        orgAttachmentQueryVo.setOrgId(id);
        orgAttachmentQueryVo.setDisabled(false);
        //查询企业所有服务资质 附件
        orgAttachmentQueryVo.setAttaType(Constant.Org.AttachmentType.SERVICE_APTITUDE);
        List<OrgAttachmentBo> srvAbilitys = orgCoreService.findOrgAttachment(orgAttachmentQueryVo);
        companyInfoView.setSrvAbilitys(srvAbilitys);
        //查询企业所有 企业资质附件
            //查询是否三证合一
        boolean isThree=orgBo.getIsThree()==null||orgBo.getIsThree().equals(0)?false:true;

        orgAttachmentQueryVo.setAttaType(Constant.Org.AttachmentType.THREE_LICENSES);
        List<OrgAttachmentBo> threeCombine = isThree?orgCoreService.findOrgAttachment(orgAttachmentQueryVo):new ArrayList<OrgAttachmentBo>();
        companyInfoView.setThreeCombine(threeCombine.size() > 0);
        companyInfoView.setThreeCompanyAbility(threeCombine);
        if(!isThree){
            Map<String,OrgAttachmentBo> map=new HashMap<>();
            List<OrgAttachmentBo> listLicenceCode=orgCoreService.findOrgAttachment(id, Constant.Org.AttachmentType.LICENSE_CODE);
            map.put("LICENSE_CODE",listLicenceCode.size()>0?listLicenceCode.get(0):null);
            List<OrgAttachmentBo> listOrgCode=orgCoreService.findOrgAttachment(id, Constant.Org.AttachmentType.ORGANIZE_CODE);
            map.put("ORGANIZE_CODE",listOrgCode.size()>0?listOrgCode.get(0):null);
            List<OrgAttachmentBo> listSax=orgCoreService.findOrgAttachment(id, Constant.Org.AttachmentType.SAX_LICENSE);
            map.put("SAX_LICENSE",listSax.size()>0?listSax.get(0):null);
            companyInfoView.setCompanyAbility(map);
        }

        //查询企业服务信息
        OrgServiceQueryVo orgServiceQueryVo=new OrgServiceQueryVo();
        orgServiceQueryVo.setOrgId(id);
        List<AldOrgServiceBo> aldOrgServiceEntityList=orgCoreService.findOrgSrv(orgServiceQueryVo);
        companyInfoView.setAldOrgServiceEntityList(aldOrgServiceEntityList);
        OrgDepartmentQueryVo orgDepartmentQueryVo=new OrgDepartmentQueryVo();
        orgDepartmentQueryVo.setOrgId(orgBo.getId());
        companyInfoView.setDepartList(orgCoreService.findCoreDepartment(orgDepartmentQueryVo));
        //根据企业ID 查询企业所有节点
        List<ServiceBo> serviceBoList= srvOrderCoreService.findNodeBoByOrgId(id);//
        companyInfoView.setServiceBoList(serviceBoList);
        //地址三级级联
        companyInfoView.setCountryList(constantsCoreService.findConstantsByKey("country_type"));
        Long countryType=orgBo.getCountryType();
        companyInfoView.setProvList(proCityDistrictService.getProvinceByCountryId(countryType==null?Constant.Country.CHINA:countryType));
        companyInfoView.setCityList(proCityDistrictService.getCityByProvinceId(orgBo.getProvId()));
        companyInfoView.setDistList(proCityDistrictService.getDistrictByCityId(orgBo.getCityId()));

        return companyInfoView;
    }

    @RequestMapping("/addDepart")
    public String addDepart(@RequestParam(required = true) Long orgId,@RequestParam(required = true) String deptName){
        Map map=new HashMap();
        //Long orgId,String deptName,Long currentUserId
        Long userId=sessionContext.getLoginUser().getUserId();
        Long rtnDepartId=orgCoreService.saveOrgDept(orgId,deptName,userId);
        if(rtnDepartId>0) {
            map.put("message", "添加成功");
            map.put("deptId",rtnDepartId);
        }
        else {
            map.put("message", "添加失败");
            map.put("deptId",-1);
        }
        return "redirect:/company/"+orgId+"/edit";
    }
    @RequestMapping("/removeDept")
    public String removeDepart(@RequestParam(required = true) Long deptId,@RequestParam Long orgId){
        Map map= map = new HashMap();
        try {
            //Long orgId,String deptName,Long currentUserId
            Long userId=sessionContext.getLoginUser().getUserId();
            orgCoreService.delOrgDept(deptId,userId);
            map.put("message","删除成功");

        } catch (Exception e) {
            e.printStackTrace();
            map.put("message","删除失败");
            map.put("rst",-1);
        }

        return "redirect:/company/"+orgId+"/edit";
    }
    @RequestMapping("/saveAttach")
    public String addSrvAbility(OrgAttachmentSaveVo vo,Integer isThree){
        vo.setCurrentUserId(sessionContext.getLoginUser().getUserId());
        vo.setCurrentUserType(Constant.User.OptType.EMPLOYEE_ORG);
        orgCoreService.saveOrgAttachment(vo);
        OrgSaveVo orgSaveVo = new OrgSaveVo();
        orgSaveVo.setId(vo.getOrgId());
        orgSaveVo.setIsThree(isThree);
        orgCoreService.saveOrgBaseInfo(orgSaveVo);
        return "redirect:/company/"+vo.getOrgId()+"/edit";
    }

    @RequestMapping("/listDeparts")
    @ResponseBody
    public List<com.aladdin.core.bo.DepartmentBo> findDeparts(@RequestParam Long orgId){
        OrgDepartmentQueryVo orgDepartmentQueryVo =   new OrgDepartmentQueryVo();
        orgDepartmentQueryVo.setOrgId(orgId);
        return this.orgCoreService.findCoreDepartment(orgDepartmentQueryVo);
    }
    @RequestMapping("/saveSrvNode")
    public String saveSrvNode(@RequestParam(required = true)String jsonStr){
        List<OrgSrvNodeSaveVo> orgSrvNodeSaveVoList=new Gson().fromJson(jsonStr,new TypeToken<List<OrgSrvNodeSaveVo>>(){}.getType());
        orgCoreService.saveOrgSrvNode(orgSrvNodeSaveVoList,sessionContext.getLoginUser().getUserId());
        return "redirect:/company/"+orgSrvNodeSaveVoList.get(0).getOrgId()+"/edit";
    }
    //修改企业基本信息
    @RequestMapping("/updateComBasicInfo")
    public String updateComBasicInfo(OrgSaveVo orgSaveVo){
        orgSaveVo.setCurrentUserId(sessionContext.getLoginUser().getUserId());
        orgCoreService.saveOrgBaseInfo(orgSaveVo);
        return "redirect:/company/info";
    }


}
