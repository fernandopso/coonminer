# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  root 'home#index'

  devise_for :users

  resources :tokens, except: :show, path: 'monitor' do
    member do
      post :privacity
      patch :language
      patch :category
      post :publish
    end

    scope module: :tokens do
      resources :collect, only: :index do
        collection do
          post :cron
        end
      end
      resources :classify, only: %w[index update]
      resources :hashtags, only: :index
      resources :languages, only: :index, path: 'idiomas'
      resources :locations, only: :index, path: 'lugares'
      resources :mentions, only: :index, path: 'mencoes'
      resources :metrics, only: :index, path: 'numeros'
      resources :mining, only: :index, path: 'resumo'
      resources :dashboard, only: :index, path: 'classificar' do
        member do
          patch :classify
        end
      end
      resources :tweets, only: :index
      resources :users, only: :index, path: 'usuarios'
      resources :validate, only: %w[index update]
      resources :links, only: :index do
        member do
          patch :ban
        end
      end
      resources :words, only: %w[index] do
        collection do
          get :banneds
        end
        member do
          patch :ban
          patch :restore
        end
      end
    end
  end

  resources :home, only: :index
  resources :sample, only: :create
  resources :example, only: :index
  resources :contacts, only: %w[index new create] do
    collection do
      get :success
    end
  end

  resources :newsletters, only: :create

  resources :sitemap, only: :index
  resources :privacy, only: :index
  resources :settings, only: :index

  resources :admin, only: [] do
    collection do
      get :users
      get :publish
    end

    scope module: :admin do
      collection do
        resources :accounts, only: %i[] do
          collection do
            put :update_all
          end
        end
        resources :rates, only: %i[index]
        resources :newsletter, only: %i[index]
        resources :categories
        resources :token, only: %i[index]
        resources :samples, only: %i[index update]
      end
    end
  end

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
