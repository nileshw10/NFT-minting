;; NFT Minting App
;; A minimal Non-Fungible Token implementation with minting and ownership check

;; Define the NFT using SIP-009 standard
(define-non-fungible-token minted-nft uint)

;; Constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-invalid-id (err u101))

;; Track total NFTs minted
(define-data-var total-supply uint u0)

;; Function 1: Mint a new NFT (only owner can mint)
(define-public (mint-nft (token-id uint) (recipient principal))
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    (asserts! (> token-id u0) err-invalid-id)
    (try! (nft-mint? minted-nft token-id recipient))
    (var-set total-supply (+ (var-get total-supply) u1))
    (ok true)))

;; Function 2: Get the owner of a specific NFT
(define-read-only (get-owner (token-id uint))
  (ok (nft-get-owner? minted-nft token-id)))
