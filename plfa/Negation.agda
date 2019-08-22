module plfa.Negation where

open import Relation.Binary.PropositionalEquality using (_≡_; refl; cong)
open import Data.Nat using (ℕ; zero; suc; _<_; z≤n; s≤s)
open import Data.Empty using (⊥; ⊥-elim)
open import Data.Sum using (_⊎_; inj₁; inj₂)
open import Data.Product using (_×_; _,_)
open import plfa.Isomorphism using (_≃_; extensionality)

-- Negation
¬_ : Set → Set
¬ A = A → ⊥

¬-elim : {A : Set} → ¬ A → A → ⊥
¬-elim ¬x x = ¬x x

infix 3 ¬_

¬¬-intro : {A : Set} → A → ¬ ¬ A
¬¬-intro x = λ ¬x → ¬x x

¬¬-intro′ : {A : Set} → A → ¬ ¬ A
¬¬-intro′ x ¬x = ¬x x

¬¬¬-elim : {A : Set} → ¬ ¬ ¬ A → ¬ A
¬¬¬-elim ¬¬¬x = λ x → ¬¬¬x (¬¬-intro x)

contraposition : {A B : Set} → (A → B) → (¬ B → ¬ A)
contraposition f ¬y x = ¬y (f x)

_≢_ : {A : Set} → A → A → Set
x ≢ y = ¬ (x ≡ y)

_ : 1 ≢ 2
_ = λ ()

peano : ∀ {m} → zero ≢ suc m
peano = λ ()

id : ⊥ → ⊥
id x = x

id′ : ⊥ → ⊥
id′ ()

id≡id′ : id ≡ id′
id≡id′ = extensionality λ ()

assimilation : {A : Set} (¬x ¬x′ : ¬ A) → ¬x ≡ ¬x′
assimilation ¬x ¬x′ = extensionality λ { x → ⊥-elim (¬x x) }

-- Exercise
<-irreflexive : ∀ n → ¬ (n < n)
<-irreflexive (suc n) (s≤s n<n) = <-irreflexive n n<n

-- Exercise
trichotomy :
  ∀ m n →
  (m < n × ¬ m ≡ n × ¬ n < m) ⊎
    (¬ m < n × m ≡ n × ¬ n < m) ⊎
      (¬ m < n × ¬ m ≡ n × n < m)
trichotomy zero zero = inj₂ (inj₁ ((λ ()) , refl , (λ ())))
trichotomy zero (suc n) = inj₁ (s≤s z≤n , (λ ()) , (λ ()))
trichotomy (suc m) zero = inj₂ (inj₂ ((λ ()) , (λ ()) , s≤s z≤n))
trichotomy (suc m) (suc n) with trichotomy m n
trichotomy (suc m) (suc n) | inj₁ (m<n , ¬m≡n , ¬m>n) =
  inj₁ (<-prf , ≡-prf , >-prf)
    where
      <-prf = s≤s m<n
      ≡-prf = λ { refl → ¬m≡n refl }
      >-prf = λ { (s≤s m>n) → ¬m>n m>n }
trichotomy (suc m) (suc n) | inj₂ (inj₁ (¬m<n , m≡n , ¬m>n)) =
  inj₂ (inj₁ (<-prf , ≡-prf , >-prf))
    where
      <-prf = λ { (s≤s m<n) → ¬m<n m<n }
      ≡-prf = cong suc m≡n
      >-prf = λ { (s≤s m>n) → ¬m>n m>n }
trichotomy (suc m) (suc n) | inj₂ (inj₂ (¬m<n , ¬m≡n , m>n)) =
  inj₂ (inj₂ (<-prf , ≡-prf , >-prf))
    where
      <-prf = λ { (s≤s m<n) → ¬m<n m<n }
      ≡-prf = λ { refl → ¬m≡n refl }
      >-prf = s≤s m>n

-- Exercise
⊎-dual-× : {A B : Set} → ¬ (A ⊎ B) ≃ (¬ A) × (¬ B)
⊎-dual-× = {!!}