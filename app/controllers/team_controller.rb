class TeamController < ApplicationController
  def index
    @users = User.all
    @teams = Team.where('created_at > ?', Time.now - 86400)
    # 86400
  end
  
  def generate_team
    
    render :text => checking_existing_team
  end
  
  def users_setting
    @user = User.new
    @users = User.all
    
    render 'users'
  end
  
  def create
    user = User.new(user_params)
    user.save
    
    redirect_to '/team/users_setting'
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update 
    @user = User.find(params[:id])
    @user.update(user_params)
    
    redirect_to '/team/users_setting'
  end
  
  def delete
    user = User.find(params[:id])
    user.destroy
    
    redirect_to '/team/users_setting'
  end
  
  def reset_current_team
    teams = Team.where('created_at > ?', Time.now - 86400)
    teams.destroy_all
    
    redirect_to '/team/users_setting'
  end
  
  private
  def checking_existing_team
    @teams = Team.where('created_at > ?', Time.now - 86400)
    # 86400
    logger.info(@teams.size)
    logger.info(@teams)
    
    if (@teams.size != 0) 
      logger.info('이미 오늘의 팀이 존재함')
      return true
    else
      logger.info('팀이 없음')
      arrange_member
    end
  end
  
  def arrange_member
    logger.info('팀원을 재 정렬한다')
    @users = User.all.order('random()')
    
    return create_team(@users)
  end
  
  def create_team(arranged_member)
    team_number = arranged_member.count / 4
    
    team_ids = []
    (0..(team_number-1)).each do |i|
      team_ids.push(Team.create(name: i))
    end
    logger.info(team_ids[0].id)
    
    i = 0
    arranged_member.each do |member|
      UserTeam.create(
        user_id: member.id,
        team_id: team_ids[i].id
      )
      i += 1
      if (i == team_number)
        i = 0
      end
    end 
    
    return false
  end
  
  def user_params
    params.require(:user).permit(:name, :department)
  end
end
