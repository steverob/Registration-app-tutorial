class Registration < ActiveRecord::Base
  attr_accessible :college, :email, :name, :phone, :pid, :year

  def formatted_year
    years={1=>"I",2=>"II",3=>"III",4=>"IV"}
    years[self.year]
  end

  def generate_pid
    self.pid="PRH"+format("%04d",self.id)
    self.save
  end
end
