require 'spec_helper'

describe WorkLog do
  it "should belongs to  AccessLevel" do
    WorkLog.reflect_on_association(:access_level).should_not be_nil
  end

  it "should have access level with id 1 by default" do
    work_log=WorkLog.new
    work_log.access_level_id.should == 1
  end
  describe "WorkLog.build_work_added_or_comment(task, user, params)" do
    it "should change access_level if presented in params[:work_log] " do
      work_log=WorkLog.build_work_added_or_comment(Task.make, User.make, { :work_log=>{ :body=>"abcd", :access_level_id=>2}, :comment=>'comment'})
      work_log.access_level_id.should == 2
    end
  end
  describe "accessed_by(user) scope" do
    it "should return work logs with given user's access level" do
      3.times{ WorkLog.make}
      3.times{ WorkLog.make(:access_level_id=>2)}
      WorkLog.all.should have(6).work_logs
      WorkLog.accessed_by(User.make(:access_level_id=>1)).should have(3).work_logs
      WorkLog.accessed_by(User.make(:access_level_id=>2)).should have(3).work_logs
    end
  end
end
