package ogehrke.distalg.sync.leaderelection.lce;

public class LeaderElectionNode {

  private long u;
  private long send;
  private enum Status {UNKNOWN,LEADER};
  private Status status;
  
  public LeaderElectionNode() {
    status=Status.UNKNOWN;
  }
  
  public static void main(String args[]) {
    
  }
  
}
