class ProfilesController < ApplicationController

    def show
        @profile = Profile.find_by(user_id: current_user.id)
        @exercize_frequency = exercize_frequency(@profile.active)
    end

    def new
        @profile = Profile.new
    end

    def create
        Profile.create!(profile_params)
        flash[:notice] = "プロフィールを作成しました"
        redirect_to root_path
    end

    def edit
        @profile = Profile.find_by(user_id: current_user.id)
    end

    def update
        @profile = Profile.find_by(user_id: current_user.id)
        @profile.update(profile_params)
        flash[:notice] = "プロフィールを変更しました"
        redirect_to user_profile_path(current_user.id)
    end



    private

    def profile_params
        params.require(:profile).permit(:nickname, :age, :gender, :height, :active).merge(user_id: current_user.id)
    end
    
    # viewで活動状況を伝える為のメソッド
    def exercize_frequency(active)
        case active
        when 0 then
            return "ほぼ運動しない。通勤、デスクワーク程度"
        when 1 then
            return "軽い運動。週に1回〜2回程度の運動"
        when 2 then
            return "中程度の運動。週に3回〜5回程度の運動"
        when 3 then
            return "激しい運動。週に6回〜7回程度の運動"
        when 4 then
            return "非常に激しい運動。1日に2回程度の運動"
        end
    end

end