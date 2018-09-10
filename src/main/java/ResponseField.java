class ResponseField {
    String State;
    String Msg;
    String Detail = null;

    ResponseField(String state, String msg) {
        this.State = state;
        this.Msg = msg;
    }

    ResponseField(String state, String msg, String detail) {
        this.State = state;
        this.Msg = msg;
        this.Detail = detail;
    }
}
