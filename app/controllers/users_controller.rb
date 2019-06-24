#This controller is used for testing the jenkins works fine or not
class UsersController < ApplicationController
  skip_before_action :authenticate_request #, only: [:register, :authenticate]

 def login
   command = AuthenticateUser.call(params[:email], params[:password])
    user = User.find_by(email: params[:email])
   if command.success?
     render json: {status: 200, data: {auth_token: command.result, user_details: user}, msg: "You are login successfully." }
   else
     render json: { error: command.errors }, status: :unauthorized
   end
 end

 #for checking
 #
 def register
  begin
    params.permit!
    user = User.new(name: params[:name], email: params[:email], password: params[:password])
    user.save!
    token = AuthenticateUser.call(params[:email], params[:password])
    render json: {status: 200, data: {auth_token: token.result, user_details: user}, msg: "You are registered successfully."}
  rescue => e
    render json: {status: 401, data: {auth_token: nil, user_details: nil}, msg: e.message}, status: :unauthorized
  end  
 end

 def questions_list  
    #render json: {status: 200, questions: Quiz.all,  msg: "Success."}
     render json: {status: 200, questions: Quiz.all.map{|que| [id: que.id, question: que.question, options: [que.opt1,que.opt2,que.opt3,que.opt4], answer: que.answer]}.flatten,  msg: "Success."}
 end

 def answer_list
   answers = Quiz.where(id: params[:ids]).map{|quiz| [quiz.id => quiz.answer]}
   render json: {status: 200, answers: answers.flatten,  msg: "Success."}
 end

end
