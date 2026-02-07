module Developer
  class PassagesController < ApplicationController
    before_action :set_passage, only: [:show, :edit, :update, :destroy]

    def index
      authorize Passage
      @passages = Passage.order(created_at: :desc)
    end

    def new
      @passage = Passage.new
      authorize @passage
    end

    def create
      @passage = Passage.new(passage_params)
      authorize @passage

      if @passage.save
        redirect_to developer_passage_path(@passage), notice: "지문이 등록되었습니다."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def show
      authorize @passage
    end

    def edit
      authorize @passage
    end

    def update
      authorize @passage
      if @passage.update(passage_params)
        redirect_to developer_passage_path(@passage), notice: "지문이 수정되었습니다."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      authorize @passage
      @passage.destroy
      redirect_to developer_passages_path, notice: "지문이 삭제되었습니다."
    end

    private

    def set_passage
      @passage = Passage.find(params[:id])
    end

    def passage_params
      params.require(:passage).permit(:title, :content, :genre, :difficulty, :min_grade, :max_grade, :subject_tags)
    end
  end
end
