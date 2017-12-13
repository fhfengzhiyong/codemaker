package cn.com.yg.model;

public class AppBaichuanOrder {
    private String id;

    private String orderId;

    private String orderStatus;

    private String orderCeateDate;

    private String createDate;

    private String isHandle;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId == null ? null : orderId.trim();
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus == null ? null : orderStatus.trim();
    }

    public String getOrderCeateDate() {
        return orderCeateDate;
    }

    public void setOrderCeateDate(String orderCeateDate) {
        this.orderCeateDate = orderCeateDate == null ? null : orderCeateDate.trim();
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate == null ? null : createDate.trim();
    }

    public String getIsHandle() {
        return isHandle;
    }

    public void setIsHandle(String isHandle) {
        this.isHandle = isHandle == null ? null : isHandle.trim();
    }
}